//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalProperty.h"
#import "RDProperty.h"
#import "RDProperty_Private.h"
#import "RDPropertyFinder.h"
#import <objc/runtime.h>

template <class Type>
class RDInternalPropertyTemplate : public RDInternalProperty
{

    static Type accessorIMP(id self, SEL _cmd)
    {
        RDPropertyFinder finder(self);

        RDInternalPropertyTemplate<Type> *property = NULL;

        property = dynamic_cast<RDInternalPropertyTemplate<Type> *>(finder.findByAccessor(_cmd));

        id value = objc_getAssociatedObject(self, property->propertyName().c_str());
        RDInternalProperty::accessorHook(&value, property);
        return property->unbox(value);
    }

    static void mutatorIMP(id self, SEL _cmd, Type value)
    {
        RDPropertyFinder finder(self);

        RDInternalPropertyTemplate<Type> *property = NULL;

        property = dynamic_cast<RDInternalPropertyTemplate<Type> *>(finder.findByMutator(_cmd));

        id boxedValue = property->box(value);
        RDInternalProperty::mutatorHook(&boxedValue, property);
        objc_setAssociatedObject(self, property->propertyName().c_str(), boxedValue, property->associationPolicy());
    }

public:
    IMP accessorImplementation()
    {
        return reinterpret_cast<IMP>(&accessorIMP);
    }
    IMP mutatorImplementation()
    {
        return reinterpret_cast<IMP>(&mutatorIMP);
    }

    virtual Type unbox(id value) = 0;
    virtual id box(Type value) = 0;
};
