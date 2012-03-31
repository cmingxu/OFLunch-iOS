//
//  VendorsViewController.h
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoM.h"

@interface VendorsViewController : UITableViewController <MoMDelegate>
    @property (retain, nonatomic) NSArray *vendors;
    @property (retain, nonatomic) MoM *mom;
    @property (retain, nonatomic)  UIActivityIndicatorView *indicator;
@end
