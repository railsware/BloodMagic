//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#include "RDInternalProperty.h"
#import "RDClassCollector.h"
#import "RDHook.h"

RDInternalProperty::~RDInternalProperty()
{
}

void RDInternalProperty::setAssociationPolicy(objc_AssociationPolicy policy)
{
    _associationPolicy = policy;
}

void RDInternalProperty::afterBoxHook(id *value, const std::string &className)
{
    RDClassCollector *collector = [RDClassCollector new];
    NSArray *hooks = [collector collectForProtocol:@protocol(RDHook)];

    for (Class<RDHook> hook in hooks) {
        [hook afterBoxingValue:value ofClass:objc_getClass(className.c_str())];
    }
}

void RDInternalProperty::beforeUnboxHook(id *value, const std::string &className)
{
    RDClassCollector *collector = [RDClassCollector new];
    NSArray *hooks = [collector collectForProtocol:@protocol(RDHook)];

    for (Class<RDHook> hook in hooks) {
        [hook beforeBoxingValue:value ofClass:objc_getClass(className.c_str())];
    }
}

const std::string &RDInternalProperty::propertyClassName() const
{
    return _propertyClassName;
}

void RDInternalProperty::setPropertyClassName(const std::string& propertyClassName)
{
    _propertyClassName = propertyClassName;
}

void RDInternalProperty::setPropertyName(const std::string& propertyName)
{
    _propertyName = propertyName;
}

const std::string& RDInternalProperty::propertyName() const
{
    return _propertyName;
}

objc_AssociationPolicy RDInternalProperty::associationPolicy() const
{
    return _associationPolicy;
}