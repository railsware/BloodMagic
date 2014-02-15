//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMInternalProperty.h"
#import "BMClassCollector.h"
#import "BMHook.h"
#import "BMProperty_Private.h"

BMInternalProperty::~BMInternalProperty()
{
}

void BMInternalProperty::setAssociationPolicy(objc_AssociationPolicy policy)
{
    _associationPolicy = policy;
}

void BMInternalProperty::setProperty(BMProperty *property)
{
    _property = property;
}

const BMProperty *BMInternalProperty::property() const {
    return _property;
}

const std::string &BMInternalProperty::propertyClassName() const
{
    return _propertyClassName;
}

void BMInternalProperty::setPropertyClassName(const std::string& propertyClassName)
{
    _propertyClassName = propertyClassName;
}

void BMInternalProperty::setPropertyName(const std::string& propertyName)
{
    _propertyName = propertyName;
}

const std::string& BMInternalProperty::propertyName() const
{
    return _propertyName;
}

objc_AssociationPolicy BMInternalProperty::associationPolicy() const
{
    return _associationPolicy;
}

NSSet *BMInternalProperty::protocols() const
{
    return _protocols;
}

void BMInternalProperty::setProtocols(NSSet *protocols)
{
    _protocols = protocols;
}
