//
//  UIBaseVC.m
//
//


#import "UIBaseVC.h"


@interface UIBaseVC ()

@end

@implementation UIBaseVC


// Custom AlertControl
// ************************
- (void) alertWithTitle:(NSString*)title
            withMessage:(NSString*)message
             withCancel:(NSString*)cancel withOptions:(NSArray*)arrOptions
         withCompletion:(void (^)(NSString *btnTitle))handler
{
    if (!cancel && !arrOptions) {
        handler(@"");
    }
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title ? : stringLoc(@"general_title")
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancel)
    {
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:cancel
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           if (handler) {
                                               handler(action.title);
                                           }
                                       }];
        
        [alertController addAction:cancelAction];
    }
    
    for (NSString* text in arrOptions)
    {
        UIAlertAction *action = [UIAlertAction
                                 actionWithTitle:text
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action)
                                 {
                                     if (handler) {
                                         handler(action.title);
                                     }
                                 }];
        
        [alertController addAction:action];
    }
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    // in case need a specific color in TintButton, remember set or use this UIColor+color
    
    //  alertController.view.tintColor = [UIColor colorCustomAlertAction];
    
}

/**
 *  when the view.backgroundColor = [UIColor clearColor], and we need the view have a blur with the behind view
 *  Remember if the view is a PresentViewController in the nav ->
 *                self.nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
 */

- (void) setBackgroundWithBlur
{
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view insertSubview:blurEffectView atIndex:0];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"*** viewDidLoad: %@", self);
    
    // register for change language
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadStrings:) name:kNotificationReloadLanguage object:nil];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    // register for did become active notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    if ([self respondsToSelector:@selector(localizedString)])
    {
        [self localizedString];
    }
    else
    {
        NSLog(@"***************");
        NSLog(@"**");
        NSLog(@"** implement method 'localizedString' into %@", self);
        NSLog(@"**");
        NSLog(@"***************");
        exit(1);
    }
}

#pragma mark - Public Methods

- (void)showActivityIndicator
{
    [self.view endEditing:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
}

- (void)hideActivityIndicator
{
    [SVProgressHUD dismiss];
}

- (void)showErrorMessage:(NSString*)message
{
    [self hideActivityIndicator];
    
    [[[UIAlertView alloc] initWithTitle:stringLoc(@"general_error")
                                message:message
                               delegate:nil
                      cancelButtonTitle:stringLoc(@"general_ok")
                      otherButtonTitles:nil] show];
}

- (void)showWarningMessage:(NSString*)message
{
    [[[UIAlertView alloc] initWithTitle:stringLoc(@"general_advertencia")
                                message:message
                               delegate:nil
                      cancelButtonTitle:stringLoc(@"general_ok")
                      otherButtonTitles:nil] show];
}

- (void)showAlertWithTitle:(NSString*)title withMessage:(NSString*)message
{
    
    [[[UIAlertView alloc] initWithTitle:title?:@""
                                message:message
                               delegate:nil
                      cancelButtonTitle:stringLoc(@"general_ok")
                      otherButtonTitles:nil] show];
}

- (void)keyboardWillShow:(NSNotification*)notification { }

- (void)keyboardWillHide:(NSNotification*)notification { }

- (void)becomeActive:(NSNotification*)notification { }

- (void) setBackgroundWithBlur
{
    if (!UIAccessibilityIsReduceTransparencyEnabled())
    {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view insertSubview:blurEffectView atIndex:0];
        
    }
}

#pragma mark - NSNotification

- (void)reloadStrings:(NSNotification*)notification
{
    [self localizedString];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
