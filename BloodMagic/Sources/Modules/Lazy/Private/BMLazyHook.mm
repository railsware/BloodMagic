//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMLazyHook.h"
#import "BMProperty.h"
#import "BMPropertyValueService.h"

@implementation BMLazyHook

+ (void)accessorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
    if (*value != nil) {
        return;
    }
    
    *value = [property.propertyClass new];
    setValueForProperty(sender, property, *value);
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end
