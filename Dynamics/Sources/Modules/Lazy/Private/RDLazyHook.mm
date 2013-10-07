//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDLazyHook.h"
#import "RDProperty.h"
#import "RDInitializerRegistry.h"
#import "RDInitializerRegistry+LazyRegistry.h"
#import "RDInitializer.h"

@implementation RDLazyHook

+ (void)accessorHook:(id *)value withProperty:(const RDProperty *)property sender:(id)sender
{
    if (*value != nil) {
        return;
    }

    RDInitializerRegistry *registry = [RDInitializerRegistry lazyRegistry];
    RDInitializer *initializer = [registry initializerForProperty:property];
    dynamics_initializer_t initializer_t = initializer.initializer;
    if (initializer_t) {
        *value = initializer_t(sender);
    } else {
        *value = [NSClassFromString(property.propertyClassName) new];
    }
}

+ (void)mutatorHook:(id *)value withProperty:(const RDProperty *)property sender:(id)sender
{
}

@end