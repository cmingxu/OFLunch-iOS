//
//  User.h
//  OFLunch
//
//  Created by kevin  on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"

@protocol LoginDelegate <NSObject>
- (void)loginSuccessfully: (int) statusCode;
- (void)loginFailed: (NSString *)reason;
@end

@interface User : Resource
@property (assign, nonatomic) NSString *password;
@property (assign, nonatomic) NSString *email;
@property (retain, nonatomic) NSMutableString *errorMessage;

@property (assign, nonatomic) BOOL loginedIn;
@property (retain, nonatomic) NSObject<LoginDelegate> *delegate;
+ (User *)currentUser;
- (void)storeUser;
- (void)authenticate;
- (void)clear;
- (BOOL)valid;
@end
