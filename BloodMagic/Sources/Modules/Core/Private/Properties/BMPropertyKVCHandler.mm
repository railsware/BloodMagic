//
// Created by Alex Denisov on 23.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMPropertyKVCHandler.h"
#import "BMPropertyFinder.h"
#import "BMInternalProperty.h"
#import "BMPropertyValueService.h"
#import "BMHook.h"
#import "BMProperty_Private.h"

@implementation BMPropertyKVCHandler

- (void)setDynamicsValue:(id)value forUndefinedKey:(NSString *)key
{
    BMPropertyFinder finder(self);

    BMInternalProperty *property = finder.findByName(key);
    if (property == NULL) {
        [self setDynamicsValue:value forUndefinedKey:key];
        return;
    }

    id<BMHook> hook = property->property().hook;
    [hook mutatorHook:&value withProperty:property->property() sender:self];
    setValueForProperty(self, property->property(), value);
}

- (id)dynamicsValueForUndefinedKey:(NSString *)key
{
    BMPropertyFinder finder(self);
    BMInternalProperty *property = finder.findByName(key);

    if (property == NULL) {
        return [self dynamicsValueForUndefinedKey:key];
    }
    
    id value = getValueForProperty(self, property->property());
    id<BMHook> hook = property->property().hook;
    [hook accessorHook:&value withProperty:property->property() sender:self];
    return value;
}

@end
