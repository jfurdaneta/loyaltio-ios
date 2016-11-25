//
//  UIColor+color.h
// 
//

#import <UIKit/UIKit.h>

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RGBCOLOR_ALPHA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


@interface UIColor (color)

+ (UIColor*) principal;

+ (UIColor*) whiteWithAlpha:(CGFloat) alpha;
+ (UIColor*) blackWithAlpha:(CGFloat) alpha;

//helpers ---
+ (UIColor *)colorWithHex:(unsigned long)hexColor;
+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
