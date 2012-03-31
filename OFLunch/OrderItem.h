//
//  OrderItem.h
//  OFLunch
//
//  Created by kevin  on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"

@interface OrderItem : Resource

@property (assign, nonatomic) int menuItemId;
@property (assign, nonatomic) int amount;
@property (assign, nonatomic) float priceOfMenuItem;
@property (readonly, nonatomic) float totalPrice;
@property (assign, nonatomic) NSString *menuItemName;

+ (OrderItem *) initWithMenuItemId:(int) miid
                           andName: (NSString *)name
                andPriceOfMenuItem: (float) price
                         andAmount: (int) amount;


@end
