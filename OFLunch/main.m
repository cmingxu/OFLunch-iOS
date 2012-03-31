//
//  main.m
//  OFLunch
//
//  Created by kevin  on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    int res;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    res =  UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    [pool drain];
    [pool release];
    return res;
}
