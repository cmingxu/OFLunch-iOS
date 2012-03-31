//
//  LoginViewController.m
//  OFLunch
//
//  Created by kevin  on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (Private) 
- (void) mask;
- (void) unmask;
@end


@implementation LoginViewController
@synthesize passwordField;
@synthesize emailField;
@synthesize submitButton;
@synthesize indicator = _indicator;

- (void)loginSuccessfully: (int) statusCode
{

    BOOL loginFailed = YES;
    NSString *message = @"";
    [self unmask];
    switch (statusCode) {
        case 200:
            loginFailed = NO;
            [[User currentUser] setLoginedIn:YES];
            [self dismissModalViewControllerAnimated:YES];
            break;
        case 204:
            message = [NSString stringWithString:@"用户不存在"];
            break;
        case 203:
            message = [NSString stringWithString:@"密码错误"];
            break;
            
        default:
            break;
    }
    
    if (loginFailed) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:message delegate:self
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else{
    }
}

- (void)loginFailed: (NSString *)reason
{
    [self unmask];    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:reason delegate:self
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];


}

- (void)mask
{
    if (!_indicator) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.center = CGPointMake(160, 240);
        self.indicator.color = [UIColor blackColor];
        self.indicator.hidesWhenStopped = YES;
        
    }
    [self.view addSubview:_indicator];
    [self.indicator startAnimating];
}
- (void)unmask
{
    [_indicator stopAnimating];
    [_indicator removeFromSuperview];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPasswordField:nil];
    [self setEmailField:nil];
    [self setSubmitButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [passwordField release];
    [emailField release];
    [submitButton release];
    [super dealloc];
}


- (IBAction)submit:(id)sender {
    User *user = [User currentUser];
    [user setEmail: emailField.text];
    [user setPassword: passwordField.text];
    if ([user valid]) {
        [self mask];
        user.delegate = self;
        [user storeUser];
        [user authenticate];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error"
                                                        message:user.errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
@end
