//
//  ConectionManager.m
//  
//

#import "ConectionManager.h"

#define kBaseURL @"www"

@implementation ConectionManager


// Fixed Params for Calls
// ********************************************

+(NSDictionary*) getParamsFixed
{
    // if all calls needs a fixed params, like
    //      APIkey,
    //      or userID, ..
    //
    
    return  @{};
    
}

// The MutableRequest for call
// ********************************************

+(NSMutableURLRequest*) getRequestGenericRequestForEndPoint:(NSString*) endPoint method:(NSString*) method params:(NSDictionary*)param
{
    
    NSString *urlStr;
    
    //Validate the URL of endPoint
    
    if ([endPoint hasPrefix:kBaseURL])
    {
        //  we are using the 'defines' of 'constants.h'
        urlStr = method;
    }
    else
    {
        // we are not using constant.h that we have to construct the URL
        urlStr = [NSString stringWithFormat:@"%@/%@", kBaseURL, endPoint];
    }

    
    
    // fixed params for all calls
    NSDictionary *paramFixed = [self getParamsFixed];
    
    
    NSMutableDictionary *requestParameters = [[NSMutableDictionary alloc] initWithDictionary:paramFixed];
    
    if (param){
        [requestParameters addEntriesFromDictionary:param];
    }
    
        NSData *jsonData;
    
    if ([method isEqualToString:@"POST"])
    {
        if (requestParameters.allKeys.count>0) {
            jsonData =[NSJSONSerialization dataWithJSONObject:requestParameters options:NSJSONWritingPrettyPrinted error:nil];
        }
    }
    else
    {
        int i = 0;
        for (NSString* key in requestParameters)
        {
            if (i==0){
                urlStr = [urlStr stringByAppendingString:@"?"];
            }else {
                urlStr = [urlStr stringByAppendingString:@"&"];
            }
            
            urlStr = [urlStr stringByAppendingFormat:@"%@=%@",key,requestParameters[key]];
            
            i++;
        }
        
        
        //escape encoding string
        
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:
                  NSUTF8StringEncoding];
    }
    

    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:30];
    
    if (jsonData){
        [request setHTTPBody:jsonData];
    }
    
    return request;
    
}

// Execute WS-Call
// ********************************************

+(void) RequestWithEndPoint:(NSString*) endPoint withMethod:(NSString*)method params:(NSDictionary*)param completion:(ServiceCompletionBlock)completion

{
    NSMutableURLRequest *request = [self getRequestGenericRequestForEndPoint:endPoint method:method params:param];
    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    // NSLog(@"begin to create");
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^
                                   {
                                       NSInteger statusCode = [((NSHTTPURLResponse*)response) statusCode];
                                       
                                       if (!error)// || (statusCode == 200))
                                       {
                                           [self manageResponseData:data completionBlock:completion];
                                       }
                                       else
                                       {
                                           [self manageError:error completionBlock:completion];
                                       }
                                       
                                   }];
                              }];
    [task resume];
}

// Manage the return values
// ********************************************

+ (void)manageResponseData:(NSData*)responseData completionBlock:(ServiceCompletionBlock)completion
{
    NSError *jsonError;
    id response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
    
    if (!jsonError && completion) {
        completion(response, nil);
    } else {
        [self manageError:jsonError completionBlock:completion];
    }

}


// Manage errors returns
// ********************************************

+ (void)manageError:(NSError*)error completionBlock:(ServiceCompletionBlock)completion
{
    // If the app is not active ignore errors
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        return;
    }
    
    completion (nil, error);
}



@end
