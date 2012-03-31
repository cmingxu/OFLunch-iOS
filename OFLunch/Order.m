//
    //  Order.m
//  OFLunch
//
//  Created by kevin  on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Order.h"
#import "MenuItem.h"
#import "OrderItem.h"
#import "User.h"

@implementation Order

@synthesize userId = _userId;
@synthesize orderItems = _orderItems;
@synthesize date = _date;
@synthesize delegate = _delegate;

- (void) dealloc
{
    [_orderItems release];
    [self setOrderItems:nil];
    [_date release];
    [self setDate:nil];
    
    [super dealloc];
}

- (id) init
{
    if (self = [super init]) {
        [self setUserId:-1];
        [self setOrderItems:[[NSMutableArray alloc]init]];
    }
    
    return self;
}

+ (Order *) loadFromSever
{
    Order *o = [[[Order alloc] init] autorelease];
    return o;
}

- (void) addToOrder: (MenuItem *)mi
{
    BOOL oiNotInOrder = YES;
    for (OrderItem *orderItem in self.orderItems) {        
        if (orderItem.menuItemId == mi.Rid) {
            orderItem.menuItemId += 1;
            oiNotInOrder = NO;
        }
    }
    
    if (oiNotInOrder) {
        OrderItem *oi = [OrderItem initWithMenuItemId:mi.Rid
                                   andName:mi.name
                                   andPriceOfMenuItem:mi.price
                                            andAmount:1];
        [self.orderItems addObject:oi];
    }
    
}


- (void) removeFromOrder: (MenuItem *)mi
{
    OrderItem *oi;
    for (OrderItem *orderItem in self.orderItems) {        
        if (orderItem.menuItemId == mi.Rid) {
            oi = orderItem;
        }
    }
    
    [self.orderItems removeObject:oi];
    
}


- (BOOL) includeMenuItem: (MenuItem *)mi
{
    for (OrderItem *orderItem in self.orderItems) {        
        if (orderItem.menuItemId == mi.Rid) {
            return YES;
        }
    }
        
        return NO;
}


- (float) totalPrice{
    float price;
    for (OrderItem *orderItem in self.orderItems) {        
        price += orderItem.totalPrice;
    }
    
    NSLog(@"price %f", price);
    return price;
}

- (void) pushToServer
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (OrderItem *oi in self.orderItems) {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects: [NSString stringWithFormat:@"%d", oi.menuItemId], [NSString stringWithFormat:@"%f", oi.priceOfMenuItem], [NSString stringWithFormat:@"%d", oi.amount], nil] forKeys:[NSArray arrayWithObjects: @"menu_item_id", @"price", @"amount", nil]];
        [array addObject:dic];
    }
     NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjects:
                                   [NSArray arrayWithObjects:[[User currentUser] email], array, nil]   forKeys:[NSArray arrayWithObjects:@"user_id", @"order_items_attributes", nil]];
    [array release];
    
    [self putResource:params forKey:@"order" toAddress:@"orders" withMethod:@"POST"];
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.delegate orderSucessfully: request.responseStatusCode];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{ 
    
    [self.delegate orderFailed: request.responseString];
}
@end
