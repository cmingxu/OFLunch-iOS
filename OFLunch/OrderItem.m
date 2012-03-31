//
//  OrderItem.m
//  OFLunch
//
//  Created by kevin  on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

@synthesize menuItemId = _menuItemId;
@synthesize priceOfMenuItem = _priceOfMenuItem;
@synthesize amount = _amount;
@synthesize totalPrice;
@synthesize menuItemName;


- (id) init
{
    if (self = [super init])
    {
        self.priceOfMenuItem = 0.0f;
    }
    
    return self;
}


+ (OrderItem *) initWithMenuItemId: (int) miid
                           andName:(NSString *)name    
                andPriceOfMenuItem: (float) price
                         andAmount: (int) amount
{
    OrderItem *oi = [[[OrderItem alloc] init] autorelease];
    
    [oi setAmount:amount];
    [oi setPriceOfMenuItem:price];
    [oi setMenuItemId:miid];
    [oi setMenuItemName:name];
    return oi;

}

- (float) totalPrice
{
    return self.amount * self.priceOfMenuItem;
}

@end
