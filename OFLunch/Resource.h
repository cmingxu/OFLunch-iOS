//
//  Resource.h
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"

#define ROOT_URL @"http://0.0.0.0:3000"

@interface Resource : NSObject

@property (assign, nonatomic) int Rid;
- (void) loadWithResource:(NSString*) address;
- (void) putResource:(NSMutableDictionary *)params forKey:(NSString *)key toAddress:(NSString *)address withMethod: (NSString *)method;

@end
