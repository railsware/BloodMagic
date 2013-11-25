//
// Created by Alex Denisov on 01.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMInitializer+LazyInitializer.h"
#import "BMInitializerRegistry+LazyRegistry.h"

@implementation BMInitializer (LazyInitializer)

+ (instancetype)lazyInitializer
{
    BMInitializer *initializer = [self new];
    initializer.registry = [BMInitializerRegistry lazyRegistry];
    return initializer;
}

@end