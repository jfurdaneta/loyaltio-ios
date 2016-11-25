//
//  ConectionHelper.m
//  
//

#import "ConectionHelper.h"

@implementation ConectionHelper


/* 
 
 THIS IS A EXAMPLE TO EXECUTE A CALL TO WS
 
 
 */
+(void) getAllPostWithCompletion:(ServiceCompletionBlock)completion
{
    // el EndPoint o lo pones aqui a saco @"http://www.miapi/wall/getPost" o
    // si tienes declarada # kBaseURL @"http://www.miapi" en constant.h, el endPoint puede ser @"/wall/getPost"
    //
    //
    // en params, es un diccionario con opciones que queramos en especial para ese WS
    //
    //
    
    [ConectionManager RequestWithEndPoint:@"XXX" withMethod:@"POST" params:nil completion:^(id response, NSError *error) {
        
        
        // si quieres puedes controlar los errores aki, o... comprobarlos en el VC donde llamas al 'getAllPostWithCompletion' eso como tu veas
        if (!error)
        {
            NSLog(@"response: %@",response);
        }
        else
        {
            // do something
        }
        
        completion(response, error);
        
    }];
}

@end
