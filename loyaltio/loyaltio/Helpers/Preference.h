//
//  Preference.h
//
//

#import <Foundation/Foundation.h>


@interface Preference : NSObject


// *******************************************
/**
 *  Change language of App sending a ISO Code
 *
 *  @param isoCode example ES, EN, .., this method after change language, reload all the ViewControllers of UIBaseVC
 */
+(void) setLanguageApp:(NSString*) isoCode;


// *******************************************
/**
 *  Get the current language in App
 *
 *  @return current isoCode language used in App
 */

+(NSString*) getIsoLanguageApp;
@end
