//
//  MenuItem.h
//  OFLunch
//
//  Created by kevin  on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"

@interface MenuItem : Resource

@property (assign, nonatomic) int vendor_id;
@property (assign, nonatomic) NSString *name;
@property (assign, nonatomic) float price;
@property (assign, nonatomic) NSString *serial_num;


+ (MenuItem *) initWithVendorId:(int) vendor_id 
                        andName:(NSString *)name
                       andPrice:(float) price
                   andSerialNum:(NSString *)serial_num
                         andRid:(int) Rid;

@end
