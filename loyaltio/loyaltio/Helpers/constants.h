//
//  constants.h
//
//

#ifndef constants_h
#define constants_h


// **********************************
//      ENVIRONMENT
// **********************************

#define ENVIRONMENT_PRO false


// **********************************
//      URLs
// **********************************


#if ENVIRONMENT_PRO == true
    #define kBaseURL @"wwww.urlPRO.com"
#else
    #define kBaseURL @"wwww.urlPRE.com"
#endif

#define kUrlLogin kBaseURL @"/login"


// **********************************
//      FONTS NAMES
// **********************************

#define fontRegular @"HelveticaNeue"
#define fontLight @"HelveticaNeue-Light"
#define fontMedium @"HelveticaNeue-Medium"
#define fontBold @"HelveticaNeue-Bold"

// *************************************
//    COLORS
// *************************************

#define kColorPrincipal [UIColor whiteColor]


// *************************************
//    STORYBOARDS
// *************************************

#define storyAprende [UIStoryboard storyboardWithName:@"name_storyboard" bundle:nil]



// *************************************
//    Languages - strings
// *************************************

// language device, if do not have match, takes de Base.lproj

#define currentLanguageBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[[[NSLocale preferredLanguages] objectAtIndex:0] componentsSeparatedByString:@"-"] objectAtIndex:0] ofType:@"lproj"]]?:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Base" ofType:@"lproj"]]

// localizedString Custom

#define stringLoc(str) NSLocalizedStringFromTableInBundle(str, nil, currentLanguageBundle, nil)

// *************************************
//     GENERICS
// *************************************

// Confirm the value its a real nil
#define IFNull(value) (value && value!=[NSNull null])?value:nil


// *************************************
//     NOTIFICATIONS NAMES
// *************************************

#define kNotificationReloadLanguage @"notificationReloadLanguage"




#endif /* constants_h */
