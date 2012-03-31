//
//  Vendor.h
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"

@protocol VendorDelegate <NSObject>
- (void)requestFinished:(NSArray *)vendors;
- (void)requestFailed:(NSString *) error;
@end

@interface Vendor : Resource
@property (assign, nonatomic) NSString *name;
@property (assign, nonatomic) int momId;
@property (assign, nonatomic) NSString *telephone;
@property (assign, nonatomic) NSString *address;
@property (retain, nonatomic) NSObject<VendorDelegate> *delegate;
@property (retain, nonatomic) NSArray *menus;

+ (Vendor*)initWithName:(NSString *)name
               andMomId:(int) momId
             andAddress:(NSString *)address
           andTelephone:(NSString *)telephone
                 andRid:(int) Rid;

- (void)loadTodayMenus;
@end
