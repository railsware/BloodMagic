//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMInitializerRegistry.h"
#import "BMInitializer.h"
#import "BMProperty.h"

@implementation BMInitializerRegistry
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

- (void)addInitializer:(BMInitializer *)initializer
{
    [_initializers addObject:initializer];
}

- (BMInitializer *)initializerForProperty:(const BMProperty *)property
{
    /// TODO: move to RDInitializerFinder
    BMInitializer *initializer = nil;
    for (BMInitializer *init in _initializers) {
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