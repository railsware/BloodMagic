//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDInitializerRegistry.h"

@implementation RDInitializerRegistry
{
    NSMutableDictionary *_initializers;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _initializers = [NSMutableDictionary new];
    }

    return self;
}

- (void)setInitializer:(dynamics_initializer_t)initializer forKey:(NSString *)key
{
    _initializers[key] = [initializer copy];
}

- (dynamics_initializer_t)initializerForKey:(NSString *)key
{
    dynamics_initializer_t initializer = _initializers[key];
    return initializer;
}


@end