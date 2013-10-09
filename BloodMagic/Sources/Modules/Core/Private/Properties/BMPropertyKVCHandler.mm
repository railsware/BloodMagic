//
// Created by Alex Denisov on 23.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMPropertyKVCHandler.h"
#import "BMPropertyFinder.h"
#import "BMInternalProperty.h"

@implementation BMPropertyKVCHandler

- (void)setDynamicsValue:(id)value forUndefinedKey:(NSString *)key
{
    BMPropertyFinder finder(self);

    BMInternalProperty *property = finder.findByName(key);
    if (property == NULL) {
        [self setDynamicsValue:value forUndefinedKey:key];
    }

    BMInternalProperty::mutatorHook(&value, property, self);
    objc_setAssociatedObject(self, property->propertyName().c_str(), value, property->associationPolicy());
}

- (id)dynamicsValueForUndefinedKey:(NSString *)key
{
    BMPropertyFinder finder(self);
    BMInternalProperty *property = finder.findByName(key);

    if (property == NULL) {
        return [self dynamicsValueForUndefinedKey:key];
    }

    id value = objc_getAssociatedObject(self, property->propertyName().c_str());
    BMInternalProperty::accessorHook(&value, property, self);
    return value;
}

@end
