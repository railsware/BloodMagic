//
// Created by Alex Denisov on 24.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "RDKVCInjector.h"
#import "RDPropertyKVCHandler.h"

@implementation RDKVCInjector

- (void)injectKVCHandlersIntoClass:(Class)klass
{
    [self injectAccessor:klass];
    [self injectMutator:klass];
}

- (void)injectAccessor:(Class)klass
{
    SEL dynamicsAccessorSelector = @selector(dynamicsValueForUndefinedKey:);
    SEL originalAccessorSelector = @selector(valueForUndefinedKey:);

    Method original = class_getInstanceMethod(klass, originalAccessorSelector);
    Method dynamics = class_getInstanceMethod([RDPropertyKVCHandler class], dynamicsAccessorSelector);
    
    if (class_addMethod(klass, originalAccessorSelector, method_getImplementation(dynamics), method_getTypeEncoding(dynamics))) {
        class_replaceMethod(klass, dynamicsAccessorSelector, method_getImplementation(original), method_getTypeEncoding(original));
    } else {
        method_exchangeImplementations(original, dynamics);
    }
}

- (void)injectMutator:(Class)klass
{
    SEL dynamicsMutatorSelector = @selector(setDynamicsValue:forUndefinedKey:);
    SEL originalMutatorSelector = @selector(setValue:forUndefinedKey:);

    Method original = class_getInstanceMethod(klass, originalMutatorSelector);
    Method dynamics = class_getInstanceMethod([RDPropertyKVCHandler class], dynamicsMutatorSelector);

    if (class_addMethod(klass, originalMutatorSelector, method_getImplementation(dynamics), method_getTypeEncoding(dynamics))) {
        class_replaceMethod(klass, originalMutatorSelector, method_getImplementation(original), method_getTypeEncoding(original));
    } else {
        method_exchangeImplementations(original, dynamics);
    }
}

@end