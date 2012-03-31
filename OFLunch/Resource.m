//
//  Resource.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Resource.h"

@implementation Resource

@synthesize Rid = _Rid;

- (id) init
{
    NSLog(@"resource init");
    if (self = [super init]) {
        _Rid = -1;
    }
    
    return self;
}

- (void) loadWithResource:(NSString*) address{
    NSString *urlAddr = [NSString stringWithFormat:@"%@/%@.json", ROOT_URL, address];
    NSURL *url = [NSURL URLWithString:urlAddr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void) putResource:(NSMutableDictionary *)params forKey:(NSString *)key toAddress:(NSString *)address withMethod: (NSString *)method{
    NSString *urlAddr = [NSString stringWithFormat:@"%@/%@.json", ROOT_URL, address];
    NSURL *url = [NSURL URLWithString:urlAddr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[params JSONRepresentation] forKey:key];
    [request setDelegate:self];
    [request startAsynchronous];
}

@end


