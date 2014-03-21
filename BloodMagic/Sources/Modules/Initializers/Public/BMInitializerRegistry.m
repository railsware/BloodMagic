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
    Class rootClass = [NSObject class];
    BOOL propertyHasClass = (property.propertyClass != rootClass);
    BOOL propertyHasProtocols = (property.protocols != nil);
    
    /// TODO: move to BMInitializerFinder
    BMInitializer *initializer = nil;
    for (BMInitializer *init in _initializers) {
        BOOL protocolsEqual = YES;
        BOOL propertyClassEqual = YES;
        BOOL containerClassEqual = YES;
        
        if (propertyHasProtocols) {
            protocolsEqual = [property.protocols isEqualToSet:init.protocolsSet];
        } else if (init.protocols) {
            protocolsEqual = NO;
        }
        
        if (!protocolsEqual) {
            continue;
        }
        
        if (propertyHasClass && init.propertyClass != rootClass) {
            propertyClassEqual = property.propertyClass == init.propertyClass;
        }
        
        if (!propertyClassEqual) {
            continue;
        }
        
        if (init.containerClass != rootClass) {
            containerClassEqual = property.containerClass == init.containerClass;
        }
        
        if (!containerClassEqual) {
            continue;
        }

        initializer = init;
        break;
    }

    return initializer;
}

@end
