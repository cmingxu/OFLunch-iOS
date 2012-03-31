//
//  LoginViewController.h
//  OFLunch
//
//  Created by kevin  on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface LoginViewController : UIViewController<LoginDelegate>
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UIButton *submitButton;
@property (retain, nonatomic) UIActivityIndicatorView *indicator;
- (IBAction)submit:(id)sender;


@end
