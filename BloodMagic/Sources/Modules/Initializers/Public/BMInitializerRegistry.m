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
    /// TODO: move to RDInitializerFinder
    BMInitializer *initializer = nil;
    for (BMInitializer *init in _initializers) {

        if (property.protocols != nil) {
            NSSet *protocols = [init protocolsSet];
            if (![property.protocols isEqualToSet:protocols]) {
                continue;
            }
        }

        if (init.propertyClass != [NSObject class]) {
            Class propertyClass = NSClassFromString(property.propertyClassName);
            if (init.propertyClass != propertyClass) {
                continue;
            }
        }

        if (init.containerClass != [NSObject class]) {
            Class containerClass = NSClassFromString(property.containerClassName);
            if (init.containerClass != containerClass) {
                continue;
            }
        }

        initializer = init;
        break;
    }

    return initializer;
}

@end