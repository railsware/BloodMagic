//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#include "RDInternalProperty.h"

RDInternalProperty::~RDInternalProperty()
{
}

void RDInternalProperty::setAssociationPolicy(objc_AssociationPolicy policy)
{
    _associationPolicy = policy;
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