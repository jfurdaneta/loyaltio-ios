//
//  ConectionManager.h
//  
//

#import <Foundation/Foundation.h>
/**
 *  Block for ConectionManager
 *
 *  @param response value from WS or response parsed
 *  @param error error
 */
typedef void(^ServiceCompletionBlock)(id response, NSError *error);

@interface ConectionManager : NSObject

// Fixed Params for Calls
// ********************************************
/**
 *  If the App needs always a fixed params like: 'apiKey', 'idUser', etc..
 *
 *  @return dictionary with this values
 */
+(NSDictionary*) getParamsFixed;

// The MutableRequest for call
// ********************************************
/**
 *  Get the principal Request
 *
 *  @param endPoint name of WS endpoint
 *  @param method   POST or GET
 *  @param param    dictionary of specific call
 *
 *  @return the MutableRequest
 */
+(NSMutableURLRequest*) getRequestGenericRequestForEndPoint:(NSString*) endPoint method:(NSString*) method params:(NSDictionary*)param;

// Execute WS-Call
// ********************************************
/**
 *  execute the real call to WS
 *
 *  @param endPoint   name of WS endpoint
 *  @param method     POST or GET
 *  @param param      dictionary of specif call
 *  @param completion
 */
+(void) RequestWithEndPoint:(NSString*) endPoint withMethod:(NSString*)method params:(NSDictionary*)param completion:(ServiceCompletionBlock)completion;

@end
