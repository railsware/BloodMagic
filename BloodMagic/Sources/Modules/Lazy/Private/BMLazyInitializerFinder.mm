//
// Created by Alex Denisov on 05.11.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#import "BMLazyInitializerFinder.h"
#import "BMProperty.h"
#import "BMInitializerRegistry.h"
#import "BMInitializerRegistry+LazyRegistry.h"
#import "BMInitializer_Private.h"

#include <map>

@implementation BMLazyInitializerFinder
{
    std::map<NSUInteger, id> _cachedInitializers;
}

+ (instancetype)finder
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (magic_initializer_t)initializerForProperty:(const BMProperty *)property
{
    NSUInteger propertyKey = (NSUInteger)property;
    magic_initializer_t initializer = _cachedInitializers[propertyKey];
    if (initializer) {
        return initializer;
    }
    
    BMInitializerRegistry *registry = [BMInitializerRegistry lazyRegistry];
    BMInitializer *lazyInitializer = [registry initializerForProperty:property];
    initializer = lazyInitializer.initializer;

    if (initializer != nil) {
        _cachedInitializers[propertyKey] = initializer;
        return initializer;
    }

    if ([BMInitializer hasDefaultInitializer]) {
        initializer = [BMInitializer defaultInitializer];
        _cachedInitializers[propertyKey] = initializer;
        return initializer;
    }

    initializer = ^id(__unused id sender) {
        return [property.propertyClass new];
    };
    _cachedInitializers[propertyKey] = initializer;
    
    return initializer;
}

@end
