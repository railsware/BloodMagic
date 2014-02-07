//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import "BMInitializerRegistry+LazyRegistry.h"


@implementation BMInitializerRegistry (LazyRegistry)

+ (instancetype)lazyRegistry
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
