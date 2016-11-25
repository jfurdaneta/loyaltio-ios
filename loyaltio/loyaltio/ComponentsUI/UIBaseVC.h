//
//  UIBaseVC.h
//  
//

#import <UIKit/UIKit.h>


@interface UIBaseVC : UIViewController

/**
 *  CUSTOM ALERTCONTROL
 *
 *  @param title      title optional, nil value requires localizedString(@"general_title")
 *  @param message    message
 *  @param cancel     text cancel button optional
 *  @param arrOptions array of options
 *  @param handler    handler response returned the text of button clicked
 */
- (void) alertWithTitle:(NSString*)title
            withMessage:(NSString*)message
             withCancel:(NSString*)cancel withOptions:(NSArray*)arrOptions
         withCompletion:(void (^)(NSString *btnTitle))handler;

/**
 *  when the view.backgroundColor = [UIColor clearColor], and we need the view have a blur with the behind view
 *  Remember if the view is a PresentViewController in the nav ->   
 *                self.nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
 */
- (void) setBackgroundWithBlur;


// Mandatory method to initialize strings
//***************************
/**
 *  to set all localized text
 */
- (void) localizedString;

/**
 *  force the ViewController with clearbackgroundcolor, and add a layer to set blur of behind VC
 */
- (void) setBackgroundWithBlur;

// Loadings and Alerts
//***************************
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
- (void)showErrorMessage:(NSString*)message;
- (void)showWarningMessage:(NSString*)message;
- (void)showAlertWithTitle:(NSString*)title withMessage:(NSString*)message;


// UINotifications
// *************************

- (void)keyboardWillShow:(NSNotification*)notification;
- (void)keyboardWillHide:(NSNotification*)notification;
- (void)becomeActive:(NSNotification*)notification;

- (void)reloadStrings:(NSNotification*)notification;
@end
