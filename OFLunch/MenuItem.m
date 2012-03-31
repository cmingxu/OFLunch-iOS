//
//  MenuItem.m
//  OFLunch
//
//  Created by kevin  on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

@synthesize vendor_id = _vendor_id;
@synthesize name = _name;
@synthesize price = _price;
@synthesize serial_num = _serial_num;


+ (MenuItem *) initWithVendorId:(int) vendor_id 
                        andName:(NSString *)name
                       andPrice:(float) price
                   andSerialNum:(NSString *)serial_num
                         andRid:(int)Rid
{
    
    MenuItem *mi = [[MenuItem alloc] init];
    
    
    
    [mi setVendor_id:vendor_id];
    [mi setName:name];
     mi.price = price;
    
    [mi setSerial_num:serial_num];
    [mi setRid:Rid];
    
    return [mi autorelease];

}

@end
