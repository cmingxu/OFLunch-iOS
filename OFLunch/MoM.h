//
//  MoM.h
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"

@protocol MoMDelegate <NSObject>
- (void)requestFinished:(NSArray *)vendors;
- (void)requestFailed:(NSString *) error;
@end

@class Vendor;

@interface MoM : Resource
@property (retain, nonatomic) NSArray *vendors;
@property (assign, nonatomic) int *mid;
@property (retain, nonatomic) NSObject<MoMDelegate> *delegate;

+ (MoM *)todayMenu;

- (void)loadTodayVendors;
@end
