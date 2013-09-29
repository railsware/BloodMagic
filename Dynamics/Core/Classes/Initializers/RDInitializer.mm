//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDInitializer.h"
#import "RDInitializerRegistry.h"

@implementation RDInitializer
{
    Class _propertyClass;
}

- (instancetype)initWithPropertyClass:(Class)klass
{
    self = [super init];
    if (self) {
        _propertyClass = klass;
    }

    return self;
}

- (void)registerInitializer:(dynamics_initializer_t)initializer
{
    [self.registry setInitializer:initializer forKey:NSStringFromClass(_propertyClass)];
}


@end