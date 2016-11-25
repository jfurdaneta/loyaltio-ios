//
//  UILabel+FormattedText.h
//  UILabel+FormattedText
//
//

#import <UIKit/UIKit.h>


@interface UILabel (Formatted)

// COLOR
// ******************

- (void) setTextColor:(UIColor *)textColor forText:(NSString*) text;
- (void)setTextColor:(UIColor *)textColor forRange:(NSRange)range;

// FONT
// ******************

- (void)setFont:(UIFont*) font forText:(NSString*) text;
- (void)setFont:(UIFont *)font forRange:(NSRange)range;

// UNDERLINE
// ************************

- (void) setUnderlineForText:(NSString*) text;
- (void) setUnderlineForRange:(NSRange) range;

// BOLD SYSTEM
// ************************

- (void) setBoldSystemForRange:(NSRange) range;
- (void) setBoldSystemForText:(NSString*) text;

// BOLD with FONT
// ************************

- (void) setBoldFont:(UIFont*) font forRange:(NSRange) range;
- (void) setBoldFont:(UIFont*) font forText:(NSString*) text;


// FORMAT FOR ALL METHODS
// **********************************

- (void) formatTextInRange: (NSRange) range withFontName:(UIFont *)font withUnderline:(BOOL)underLine withBold:(BOOL) bold withColor:(UIColor*) textColor;
@end
