//
//  Order.h
//  OFLunch
//
//  Created by kevin  on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"

@protocol OrderDelegate <NSObject>
- (void)orderSucessfully: (int) statusCode;
- (void)orderFailed: (NSString *)reason;
@end

@class MenuItem;

@interface Order : Resource
@property (assign, nonatomic) int userId;
@property (retain, nonatomic) NSDate *date;
@property (retain, nonatomic) NSMutableArray *orderItems;

@property (retain, nonatomic) NSObject<OrderDelegate> *delegate;

+ (Order *) loadFromSever;
- (void) addToOrder: (MenuItem *)oi;
- (BOOL) includeMenuItem: (MenuItem *)mi;
- (float) totalPrice;
- (void) pushToServer;
@end
