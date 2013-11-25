//
// Created by Alex Denisov on 05.11.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#import "BMLazyInitializerFinder.h"
#import "BMProperty.h"
#import "BMInitializerRegistry.h"
#import "BMInitializerRegistry+LazyRegistry.h"

@implementation BMLazyInitializerFinder

- (magic_initializer_t)initializerForProperty:(const BMProperty *)property
{
    BMInitializerRegistry *registry = [BMInitializerRegistry lazyRegistry];
    BMInitializer *lazyInitializer = [registry initializerForProperty:property];
    magic_initializer_t initializer = lazyInitializer.initializer;
    if (initializer == nil) {
        initializer = ^id(__unused id sender) {
            return [NSClassFromString(property.propertyClassName) new];
        };
    }

    return initializer;
}

@end