//
//  UIView+view.m


#import "UIView+view.h"

@implementation UIView (view)


// normal layoutIfNeed with animation
//**************************************

-(void) layoutIfNeededAnimated
{
    [UIView animateWithDuration:kTimeIn delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self layoutIfNeeded];
        
    }
    completion:nil];
}

// AddSubview with Constraints
//**************************************

-(void) addSubviewSpecial:(UIView*) child animated:(BOOL) animated
{
    child.alpha=0;
    [self addSubview:child];
    
    CGFloat time = 0;
    
    child.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"childview":child};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[childview]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[childview]-0-|" options:0 metrics:nil views:views]];
    
    if (animated) time = kTimeIn;
    
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        child.alpha = 1;
    } completion:nil];
}

// RemoveSubview with Constraints
//**************************************

-(void) removeFromSuperviewSpecial:(BOOL) animated
{
    CGFloat time = 0;
    if (animated) time = kTimeOut;
    
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}
@end
