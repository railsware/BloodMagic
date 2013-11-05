//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMLazyHook.h"
#import "BMProperty.h"
#import "BMPropertyValueService.h"
#import "BMLazyInitializerFinder.h"

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

    BMLazyInitializerFinder *finder = [BMLazyInitializerFinder new];
    magic_initializer_t initializer = [finder initializerForProperty:property];

    __weak id weakSender = sender;
    *value = initializer(weakSender);

    setValueForProperty(sender, property, *value);
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end