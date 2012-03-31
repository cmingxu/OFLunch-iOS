//
//  AppDelegate.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "VendorsViewController.h"
#import "OrderViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "Order.h"
#import "User.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize vendorNavController = _vendorNavController;
@synthesize orderNavController = _orderNavController;
@synthesize settingNavController = _settingNavController;
@synthesize tabController = _tabController;
@synthesize order = _order;

- (void)dealloc
{
    [_vendorNavController release];
    [_orderNavController release];
    [_settingNavController release];
    [_tabController release];
    [_order release];
    
    [super dealloc];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"tabchangedddd");
    if (![[User currentUser] loginedIn]) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.tabController presentModalViewController:loginViewController animated:YES];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    _order = [[Order alloc] init];
    
    
    VendorsViewController *menuController = [[VendorsViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    _vendorNavController = [[[UINavigationController alloc] initWithRootViewController:menuController] autorelease];
     _vendorNavController.tabBarItem.image = [UIImage imageNamed:@"96-book.png"];

   
    [menuController release];
    
    
    OrderViewController *orderController = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
    _orderNavController = [[[UINavigationController alloc] initWithRootViewController:orderController] autorelease];
    _orderNavController.tabBarItem.image = [UIImage imageNamed:@"80-shopping-cart.png"];
    [orderController release];
    
    
    
    SettingViewController *settingController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    _settingNavController = [[[UINavigationController alloc] initWithRootViewController:settingController] autorelease];
    
    _settingNavController.tabBarItem.image = [UIImage imageNamed:@"157-wrench.png"];

    [settingController release];
    
    
    _tabController = [[UITabBarController alloc] init];
    [_tabController setViewControllers:[[NSArray arrayWithObjects:_vendorNavController, _orderNavController, _settingNavController, nil] autorelease]];
    
    _tabController.delegate = self;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window addSubview: _tabController.view];
    [self.window makeKeyAndVisible];
    

    if (![[User currentUser] loginedIn]) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.tabController presentModalViewController:loginViewController animated:YES];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
