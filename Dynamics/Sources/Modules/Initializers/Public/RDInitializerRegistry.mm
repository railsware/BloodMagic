//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDInitializerRegistry.h"
#import "RDInitializer.h"
#import "RDProperty.h"

@implementation RDInitializerRegistry
{
    NSMutableArray *_initializers;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _initializers = [NSMutableArray new];
    }

    return self;
}

- (void)addInitializer:(RDInitializer *)initializer
{
    [_initializers addObject:initializer];
}

- (RDInitializer *)initializerForProperty:(const RDProperty *)property
{
    RDInitializer *initializer = nil;
    for (RDInitializer *init in _initializers) {
        Class propertyClass = NSClassFromString(property.propertyClassName);
        if (init.propertyClass != propertyClass) {
            continue;
        }

        if (init.containerClass == [NSObject class]) {
            initializer = init;
            break;
        }

        Class containerClass = NSClassFromString(property.containerClassName);
        if (init.containerClass != containerClass) {
            continue;
        }

        initializer = init;
        break;
    }

    return initializer;
}


@end