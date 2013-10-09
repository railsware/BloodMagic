//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMInitializer.h"
#import "BMInitializerRegistry.h"

@implementation BMInitializer

- (instancetype)init
{
    self = [super init];
    self.containerClass = [NSObject class];

    return self;
}

- (void)registerInitializer
{
    [self.registry addInitializer:self];
}

@end