//
//  OrderViewController.h
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@class Order;

@interface OrderViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, OrderDelegate>
@property (retain, nonatomic) IBOutlet UITableView *orderItemsTableview;
@property (retain, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (assign, nonatomic) Order *order;


@end
