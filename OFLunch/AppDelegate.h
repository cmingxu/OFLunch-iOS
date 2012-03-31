//
//  AppDelegate.h
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate >

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *vendorNavController;
@property (retain, nonatomic) UINavigationController *orderNavController;
@property (retain, nonatomic) UINavigationController *settingNavController;
@property (retain, nonatomic) UITabBarController *tabController;

@property (retain, nonatomic) Order *order;

@end
