//
//  BMInjectableHook.m
//  BloodMagic
//
//  Created by AlexDenisov on 8/7/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInjectableHook.h"
#import "BMProperty.h"
#import "BMPropertyValueService.h"
#import "BMInjectableInitializerFinder.h"

@implementation BMInjectableHook

+ (void)accessorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
    if (*value != nil) {
        return;
    }
    
    BMInjectableInitializerFinder *finder = [BMInjectableInitializerFinder finder];
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
        
        if ([sender respondsToSelector:@selector(bm_propertyInjected:value:)]) {
            [sender bm_propertyInjected:property.name value:*value];
        }
    }
    
    setValueForProperty(sender, property, *value);
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end
