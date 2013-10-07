//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#include "RDInternalProperty.h"
#import "RDClassCollector.h"
#import "RDHook.h"
#import "RDProperty.h"

RDInternalProperty::~RDInternalProperty()
{
}

void RDInternalProperty::setAssociationPolicy(objc_AssociationPolicy policy)
{
    _associationPolicy = policy;
}

void RDInternalProperty::setProperty(RDProperty *property)
{
    _property = property;
}

void RDInternalProperty::mutatorHook(id *value, const RDInternalProperty *internal, id sender)
{
    RDClassCollector *collector = [RDClassCollector new];
    NSArray *hooks = [collector collectForProtocol:@protocol(RDHook)];

    for (Class<RDHook> hook in hooks) {
        [hook mutatorHook:value withProperty:internal->property() sender:sender];
    }
}

void RDInternalProperty::accessorHook(id *value, const RDInternalProperty *internal, id sender)
{
    RDClassCollector *collector = [RDClassCollector new];
    NSArray *hooks = [collector collectForProtocol:@protocol(RDHook)];

    for (Class<RDHook> hook in hooks) {
        [hook accessorHook:value withProperty:internal->property() sender:sender];
    }
}

const RDProperty *RDInternalProperty::property() const {
    return _property;
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