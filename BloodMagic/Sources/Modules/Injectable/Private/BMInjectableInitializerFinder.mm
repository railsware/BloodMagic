//
// Created by Alex Denisov on 05.11.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#import "BMInjectableInitializerFinder.h"
#import "BMProperty.h"
#import "BMInitializerRegistry.h"
#import "BMInitializerRegistry+Injectable.h"
#import "BMInitializer_Private.h"

#include <map>

@implementation BMInjectableInitializerFinder
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
    
    BMInitializerRegistry *registry = [BMInitializerRegistry injectableRegistry];
    BMInitializer *lazyInitializer = [registry initializerForProperty:property];
    initializer = lazyInitializer.initializer;

    if (initializer != nil) {
        _cachedInitializers[propertyKey] = initializer;
        return initializer;
    }

    initializer = ^id(__unused id sender) {
        return nil;
    };
    _cachedInitializers[propertyKey] = initializer;
    
    return initializer;
}

- (void)invalidate
{
	_cachedInitializers.clear();
}

@end
