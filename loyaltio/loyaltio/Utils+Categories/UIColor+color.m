//
//  UIColor+color.m
//
//

#import "UIColor+color.h"

@implementation UIColor (color)



+ (UIColor*) principal
{
    return [self colorFromHexString:@"#236ead"];

}

+ (UIColor*) whiteWithAlpha:(CGFloat) alpha
{
    return RGBCOLOR_ALPHA(255, 255, 255, alpha);
}

+ (UIColor*) blackWithAlpha:(CGFloat) alpha
{
    return RGBCOLOR_ALPHA(0, 0, 0, alpha);
}





// helpers ------

+ (UIColor *)colorWithHex:(unsigned long)hexColor
{
    CGFloat blue = (hexColor & 255) / 256.0f;
    CGFloat green = (hexColor >> 8 & 255) / 256.0f;
    CGFloat red = (hexColor >> 16 & 255) / 256.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end
