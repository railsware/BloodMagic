//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMInitializerRegistry.h"
#import "BMInitializer_Private.h"
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
    /// TODO: move to BMInitializerFinder
    BMInitializer *initializer = nil;
    for (BMInitializer *init in _initializers) {
        if (property.protocols) {
            NSSet *protocols = [init protocolsSet];
            if (![property.protocols isEqualToSet:protocols]) {
                continue;
            }
        } else if (init.protocols) {
            continue;
        }
        
        if (init.propertyClass != [NSObject class]) {
            if (init.propertyClass != property.propertyClass) {
                continue;
            }
        }

        if (init.containerClass != [NSObject class]) {
            if (init.containerClass != property.containerClass) {
                continue;
            }
        }

        initializer = init;
        break;
    }

    return initializer;
}

@end
