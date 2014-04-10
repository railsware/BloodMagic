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

    BMLazyInitializerFinder *finder = [BMLazyInitializerFinder finder];
    magic_initializer_t initializer = [finder initializerForProperty:property];

    if (initializer) {
        __weak id weakSender = sender;
        *value = initializer(weakSender);
        SEL injectedHook = NSSelectorFromString([NSString stringWithFormat:@"%@Injected:", property.name]);
        if ([sender respondsToSelector:injectedHook]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [sender performSelector:injectedHook withObject:*value];
#pragma clang diagnostic pop
        }
    }

    setValueForProperty(sender, property, *value);
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end
