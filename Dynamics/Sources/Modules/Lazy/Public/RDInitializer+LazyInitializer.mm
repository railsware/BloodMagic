//
// Created by Alex Denisov on 01.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDInitializer+LazyInitializer.h"
#import "RDInitializerRegistry+LazyRegistry.h"

@implementation RDInitializer (LazyInitializer)

+ (instancetype)lazyInitializer
{
    RDInitializer *initializer = [self new];
    initializer.registry = [RDInitializerRegistry lazyRegistry];
    return initializer;
}

@end