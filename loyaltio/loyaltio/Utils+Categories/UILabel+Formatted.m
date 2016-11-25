//
//  UILabel+FormattedText.m
//  UILabel+FormattedText
//


#import "UILabel+Formatted.h"


@implementation UILabel (Formatted)

// COLOR
// ******************

- (void) setTextColor:(UIColor *)textColor forText:(NSString*) text
{
    NSRange range = [self.text rangeOfString:text];
    [self formatTextInRange:range withFontName:nil withUnderline:NO withBold:NO withColor:textColor];
}

- (void)setTextColor:(UIColor *)textColor forRange:(NSRange)range
{
    [self formatTextInRange:range withFontName:nil withUnderline:NO withBold:NO withColor:textColor];
}

// FONT
// ******************

- (void)setFont:(UIFont*) font forText:(NSString*) text
{
    NSRange range = [self.text rangeOfString:text];
    [self formatTextInRange:range withFontName:font withUnderline:NO withBold:NO withColor:nil];
}

- (void)setFont:(UIFont *)font forRange:(NSRange)range
{
    [self formatTextInRange:range withFontName:font withUnderline:NO withBold:NO withColor:nil];
}


// UNDERLINE
// ************************

- (void) setUnderlineForText:(NSString*) text
{
    NSRange range = [self.text rangeOfString:text];
    [self formatTextInRange:range withFontName:nil withUnderline:YES withBold:NO withColor:nil];
}

- (void) setUnderlineForRange:(NSRange) range
{
    [self formatTextInRange:range withFontName:nil withUnderline:YES withBold:NO withColor:nil];
}

// BOLD SYSTEM
// ************************

- (void) setBoldSystemForRange:(NSRange) range
{
    [self formatTextInRange:range withFontName:nil withUnderline:NO withBold:YES withColor:nil];
}

- (void) setBoldSystemForText:(NSString*) text
{
    NSRange range = [self.text rangeOfString:text];
    [self formatTextInRange:range withFontName:nil withUnderline:NO withBold:YES withColor:nil];
}

// BOLD with FONT
// ************************

- (void) setBoldFont:(UIFont*) font forRange:(NSRange) range
{
    [self formatTextInRange:range withFontName:font withUnderline:NO withBold:YES withColor:nil];
}

- (void) setBoldFont:(UIFont*) font forText:(NSString*) text
{
    NSRange range = [self.text rangeOfString:text];
    
    [self formatTextInRange:range withFontName:font withUnderline:NO withBold:YES withColor:nil];
}



// FORMAT FOR ALL METHODS
// **********************************

- (void) formatTextInRange: (NSRange) range withFontName:(UIFont *)font withUnderline:(BOOL)underLine withBold:(BOOL) bold withColor:(UIColor*) textColor
{
    
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText;
    
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    
    if (font)
    {
        // para la selección queremos una fuente en concreto
        
        [attributedText setAttributes:@{NSFontAttributeName:font} range:range];
    }
    else if (bold)
    {
        // que este en mayúsculas
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]} range:range];
    }
    else
    {
        // la que tiene toda x defecto el label
        [attributedText setAttributes:@{NSFontAttributeName:self.font} range:range];
    }
    
    
    
    if (underLine)
    {
        //el texto va subrayado
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:[NSNumber numberWithInt:1]
                               range:range];
    }
    
    if (textColor)
    {
        [attributedText addAttribute: NSForegroundColorAttributeName
                               value: textColor
                               range: range];
    }
    
    
    self.attributedText = attributedText;
    
}


@end
