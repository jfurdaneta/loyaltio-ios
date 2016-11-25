//
//  Utils.m
//
//  Created by Omar on 11/7/16.
//  Copyright © 2016 Developer. All rights reserved.
//

#import "Utils.h"

#define kMiniumHeightForLabels 2.0

@implementation Utils


/**
 *  To determinate height of label with specific text
 *
 *  @param text       text
 *  @param widthValue actual width label
 *  @param font       label font
 *
 *  @return height for this label
 */

- (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGFloat result = font.pointSize+4;
    if (text) {
        CGSize size;
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);
        result = MAX(size.height, result); //At least one row
    }
    if (result<kMiniumHeightForLabels) result=kMiniumHeightForLabels;
    return result;
}

// *******************
// *
// *  REFERENT IMAGES
// *
// *******************

+ (UIImage *)scaleImage:(UIImage*)image toMaxResolution:(int)resolution
{
    image = [self normalizedOrientation];
    
    CGImageRef imgRef = [image CGImage];
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    if (width>resolution || height>resolution)
    {
        
        CGSize newSize;
        float ratio;
        
        if (width>height)
        {
            // landscape image
            
            ratio=width/resolution;
            newSize=CGSizeMake(resolution, height/ratio );
        }
        else if (width<height)
        {
            // portrait image
            
            ratio=height/resolution;
            newSize=CGSizeMake(width/ratio, resolution);
        }
        else
        {
            // square image
            
            if (width > resolution) {
                newSize=CGSizeMake((float) resolution, (float) resolution);
            } else {
                newSize=CGSizeMake((float) width, (float) height);
            }
        }
        
        UIGraphicsBeginImageContext(CGSizeMake(newSize.width, newSize.height));
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    else
    {
        return image;
    }
}

+ (UIImage *)normalizedOrientation:(UIImage*)image
{
    UIImage *normalizedImage;
    
    if (image.imageOrientation != UIImageOrientationUp)
    {
        UIGraphicsBeginImageContextWithOptions(photo.size, NO, photo.scale);
        [photo drawInRect:(CGRect){0, 0, photo.size}];
        normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else {
        normalizedImage = image;
    }
    return normalizedImage;
}

@end
