//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMLazyHook.h"
#import "BMProperty.h"
#import "BMInitializerRegistry.h"
#import "BMInitializerRegistry+LazyRegistry.h"
#import "BMInitializer.h"

@implementation BMLazyHook

+ (void)accessorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
    if (*value != nil) {
        return;
    }

    Class containerClass = NSClassFromString(property.containerClassName);
    if (![containerClass conformsToProtocol:@protocol(BMLazy)]) {
        return;
    }

    BMInitializerRegistry *registry = [BMInitializerRegistry lazyRegistry];
    BMInitializer *initializer = [registry initializerForProperty:property];
    magic_initializer_t initializer_t = initializer.initializer;
    if (initializer_t) {
        *value = initializer_t(sender);
    } else {
        *value = [NSClassFromString(property.propertyClassName) new];
    }
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end