//
//  UIView+view.h


#import <UIKit/UIKit.h>

#define kTimeIn 0.25
#define kTimeOut 0.15


@interface UIView (view)


//**************************************
/**
 *  normal layoutIfNeed with animation
 */

-(void) layoutIfNeededAnimated;


//**************************************
/**
 *  AddSubview with Constraints
 *
 *  @param child    the child view
 *  @param animated YES: to insert with Alpha animation
 */
-(void) addSubviewSpecial:(UIView*) child animated:(BOOL) animated;


//**************************************
/**
 *  RemoveSubview
 *
 *  @param animated YES: to remove with Alpha animation
 */
-(void) removeFromSuperviewSpecial:(BOOL) animated;

@end
