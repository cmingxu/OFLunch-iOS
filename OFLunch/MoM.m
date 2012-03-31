//
//  MoM.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoM.h"
#import "Vendor.h"


@implementation MoM

@synthesize vendors = _vendors;
@synthesize mid = _mid;
@synthesize delegate = _delegate;

- (void)dealloc
{
    
    self.vendors = nil;
    [super dealloc];
}

- (id) init
{
    if (self = [super init]) {
        self.vendors = [[NSArray alloc] init];
    }
    return self;
}



+ (MoM *)todayMenu{
    return [[[MoM alloc] init] autorelease];
}


- (void)loadTodayVendors{
    [super loadWithResource: @"vendors/vendors_for_today"];
}




- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString *responseString = [request responseString];
    NSArray *memberList = [[NSArray alloc] initWithArray:[parser objectWithString:responseString error:nil]];

    NSMutableArray *vendors = [[[NSMutableArray alloc] init] autorelease];
    for(NSDictionary *member in memberList)
    {
        
        Vendor *v = [Vendor initWithName:[member objectForKey:@"name"]
                                                             andMomId:1
                                      andAddress:[member objectForKey:@"address"]
                                    andTelephone:[member objectForKey:@"phone_number"]
                                          andRid:(int)[member objectForKey:@"id"]];
        
    
        [vendors addObject:v];
 
    }
    
    NSArray *arr = [[[NSArray alloc] initWithArray:vendors] autorelease];
    
    [self.delegate requestFinished: arr];
    [parser release];
 
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
     NSLog(@"Error: %@",[[request error] localizedDescription]);
     [self.delegate requestFailed: [[request error] localizedDescription]];
}

@end
