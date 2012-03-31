//
//  Vendor.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vendor.h"
#import "MenuItem.h"

@implementation Vendor 

@synthesize name = _name;
@synthesize momId = _momId;
@synthesize address = _address;
@synthesize telephone = _telephone;
@synthesize menus = _menus;
@synthesize delegate = _delegate;


- (void) dealloc
{
    self.menus = nil;
    [super dealloc];
}

- (id) init
{ 
    if (self = [super init]) {
        self.menus = [[NSArray alloc] init];
    }
    return self;

}

+ (Vendor*)initWithName:(NSString *)name
               andMomId:(int) momId
             andAddress:(NSString *)address
           andTelephone:(NSString *)telephone
                 andRid:(int)Rid
{
    NSLog(@"rinitWithName  vendor");
    Vendor *v = [[Vendor alloc] init];
    [v setName:name];
    [v setMomId:momId];
    [v setAddress:address];
    [v setTelephone:telephone];
    [v setRid:Rid];
    
    return [v autorelease];
}


- (void)loadTodayMenus{
    NSString *s = [NSString stringWithFormat:@"vendors/%@/menu_items", [self Rid]];
    [super loadWithResource: s];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString *responseString = [request responseString];
    NSArray *memberList = [[[NSArray alloc] initWithArray:[parser objectWithString:responseString error:nil]] autorelease];
    
    NSMutableArray *menus = [[[NSMutableArray alloc] init] autorelease];
    for(NSDictionary *member in memberList)
    {

     
        float f = [[member objectForKey:@"price"] floatValue];
        int Rid = [[member objectForKey:@"id"] intValue];

        MenuItem *m = [MenuItem initWithVendorId:(int)[member objectForKey:@"vendor_id"]
                                                              andName:[member objectForKey:@"name"]
                                                            andPrice:f
                                                        andSerialNum:[member objectForKey:@"serial_num"]
                                                               andRid:Rid];
        
        [menus addObject:m];
        
    }
    
    NSArray *arr = [[[NSArray alloc] initWithArray:menus] autorelease];
    [self.delegate requestFinished: arr];
    [parser release];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Error: %@",[[request error] localizedDescription]);
    [self.delegate requestFailed: [[request error] localizedDescription]];
}

@end
