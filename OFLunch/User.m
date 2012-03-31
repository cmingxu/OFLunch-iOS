//
//  User.m
//  OFLunch
//
//  Created by kevin  on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

static User *currentUser;

@implementation User
@synthesize password = _password;
@synthesize email = _email;
@synthesize loginedIn = _loginedIn;
@synthesize delegate = _delegate;
@synthesize errorMessage = _errorMessage;


- (void) dealloc
{
    [self setEmail:nil];
    [self setLoginedIn:NO];
    [self setPassword:nil];
    [self setErrorMessage:nil];
    
    [super dealloc];
}

- (BOOL) valid
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if (self.email.length == 0) {
        [str appendString:@"Email不能空"];
        NSLog(@"Email不能空");
    }
    
    if (self.password.length == 0) {
        [str appendString:@" 密码不能空"];
    }

    [self setErrorMessage:str];
    [str release];
    return self.errorMessage.length == 0;
}

- (User *) init
{
    if (self = [super init]) {
        [self setPassword: @""];
        [self setEmail:@""];
        [self setLoginedIn:NO];
    }
    
    return self;
}
+ (User *)currentUser{
    if (!currentUser) {
        currentUser = [[User alloc] init];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"email"]){
        [currentUser setEmail:[[NSUserDefaults standardUserDefaults] objectForKey:@"email"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"password"]) {
        [currentUser setPassword:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loginedIn"]) {
        [currentUser setLoginedIn:[[NSUserDefaults standardUserDefaults] boolForKey:@"loginedIn"]];
    }
    return currentUser;
}

- (void)storeUser{
    [[NSUserDefaults standardUserDefaults] setValue:self.email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:self.password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setBool:self.loginedIn forKey:@"loginedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)authenticate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:self.email, self.password, nil]   forKeys:[NSArray arrayWithObjects:@"email", @"password", nil]];
    
    [self putResource:params forKey:@"authenticate" toAddress:@"authenticate" withMethod:@"POST"];
//    [params release];
 
}

- (void)clear
{
    [self setPassword: @""];
    [self setEmail:@""];
    [self setLoginedIn:NO];
    [self storeUser];
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.delegate loginSuccessfully: [request responseStatusCode]];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{ 
 
    [self.delegate loginFailed];
}

@end
