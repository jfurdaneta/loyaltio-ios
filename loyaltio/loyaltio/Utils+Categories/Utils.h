//
//  Utils.h
//  Vudoir
//
//  Created by Omar on 11/7/16.
//  Copyright © 2016 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

/**
 *  To determinate height of label with specific text
 *
 *  @param text       text
 *  @param widthValue actual width label
 *  @param font       label font
 *
 *  @return height for this label
 */

- (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;

// *******************
// *
// *  REFERENT IMAGES
// *
// *******************

+ (UIImage *)scaleImage:(UIImage*)image toMaxResolution:(int)resolution;

/**
 *  set the photo to the correct orientation
 *
 *  @param image Image
 *
 *  @return imageNormalized
 */
+ (UIImage *)normalizedOrientation:(UIImage*)image;
@end
