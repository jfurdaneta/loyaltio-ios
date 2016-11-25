//
//  UIFont+font.m
//  
//

#import "UIFont+font.h"

@implementation UIFont (font)

+(UIFont*) RegularWithSize:(CGFloat) size
{
    return [UIFont fontWithName:fontRegular size:size];
}

+(UIFont*) LightWithSize:(CGFloat) size
{
    return [UIFont fontWithName:fontLight size:size];
}

+(UIFont*) MediumWithSize:(CGFloat) size
{
    return [UIFont fontWithName:fontMedium size:size];
}

+(UIFont*) BoldWithSize:(CGFloat) size
{
    return [UIFont fontWithName:fontBold size:size];
}



/*
 
 if you need a more specic kinds of fonts methods like example:
 
 
    +(UIFont*) TitlesHeader
    {
        return [self MediumWithSize:19.0];
    }
 
 
 */
@end
