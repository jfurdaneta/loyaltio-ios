//
//  Preference.m
//
//

#import "Preference.h"


@implementation Preference

+(void) setLanguageApp:(NSString*) isoCode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[NSArray arrayWithObjects:isoCode, nil]
                                              forKey:@"AppleLanguages"];
    
    
    [userDefaults synchronize];
    

    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReloadLanguage object:nil];
    
}

+(NSString*) getIsoLanguageApp
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
}



@end
