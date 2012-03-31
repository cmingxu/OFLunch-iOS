//
//  MenuViewController.h
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vendor.h"
#import "AppDelegate.h"

@interface MenuViewController : UITableViewController <VendorDelegate>
 @property (retain, nonatomic) Vendor *vendor;
 @property (retain, nonatomic) NSArray *menus;
@end
