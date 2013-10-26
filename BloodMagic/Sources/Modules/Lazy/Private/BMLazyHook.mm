//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMLazyHook.h"
#import "BMProperty_Private.h"
#import "BMInitializerRegistry.h"
#import "BMInitializerRegistry+LazyRegistry.h"

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
        __weak id weakSender = sender;
        *value = initializer_t(weakSender);
    } else {
        *value = [NSClassFromString(property.propertyClassName) new];
    }
    /// TODO: encapsulate this stuff
    objc_setAssociatedObject(sender, property.internalProperty->propertyName().c_str(), *value, property.internalProperty->associationPolicy());
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end