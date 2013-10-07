//
// Created by Alex Denisov on 23.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "RDPropertyKVCHandler.h"
#import "RDPropertyFinder.h"
#import "RDInternalProperty.h"

@implementation RDPropertyKVCHandler

- (void)setDynamicsValue:(id)value forUndefinedKey:(NSString *)key
{
    RDPropertyFinder finder(self);

    RDInternalProperty *property = finder.findByName(key);
    if (property == NULL) {
        [self setDynamicsValue:value forUndefinedKey:key];
    }

    RDInternalProperty::mutatorHook(&value, property, self);
    objc_setAssociatedObject(self, property->propertyName().c_str(), value, property->associationPolicy());
}

- (id)dynamicsValueForUndefinedKey:(NSString *)key
{
    RDPropertyFinder finder(self);
    RDInternalProperty *property = finder.findByName(key);

    if (property == NULL) {
        return [self dynamicsValueForUndefinedKey:key];
    }

    id value = objc_getAssociatedObject(self, property->propertyName().c_str());
    RDInternalProperty::accessorHook(&value, property, self);
    return value;
}

@end
