//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMInitializerRegistry.h"
#import "BMInitializer_Private.h"
#import "BMProperty.h"

static BOOL class_isEqualOrSubclass(Class base, Class child)
{
    if (base == child) {
        return YES;
    }

    Class superClass = child;
    BOOL result = NO;

    while (true) {
        superClass = class_getSuperclass(superClass);

        if (!superClass || superClass == [NSObject class]) {
            break;
        }

        if (superClass == base) {
            result = YES;
            break;
        }
    }

    return result;
}

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
        if (property.protocols != nil) {
            NSSet *protocols = [init protocolsSet];
            if (![property.protocols isEqualToSet:protocols]) {
                continue;
            }
        }

        if (init.propertyClass != [NSObject class]) {

            if (init.propertyClass != property.propertyClass) {
                continue;
            }
        }

        if (init.containerClass != [NSObject class]) {
            BOOL isEqualOrSubclass = class_isEqualOrSubclass(property.containerClass, init.containerClass);
            if (!isEqualOrSubclass) {
                continue;
            }
        }

        initializer = init;
        break;
    }

    return initializer;
}

@end
