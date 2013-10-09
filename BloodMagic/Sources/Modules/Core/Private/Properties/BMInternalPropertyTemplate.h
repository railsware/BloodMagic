//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalProperty.h"
#import "BMProperty.h"
#import "BMProperty_Private.h"
#import "BMPropertyFinder.h"
#import <objc/runtime.h>

template <class Type>
class BMInternalPropertyTemplate : public BMInternalProperty
{

    static Type accessorIMP(id self, SEL _cmd)
    {
        BMPropertyFinder finder(self);

        BMInternalPropertyTemplate<Type> *property = NULL;

        property = dynamic_cast<BMInternalPropertyTemplate<Type> *>(finder.findByAccessor(_cmd));

        id value = objc_getAssociatedObject(self, property->propertyName().c_str());
        BMInternalProperty::accessorHook(&value, property, self);
        return property->unbox(value);
    }

    static void mutatorIMP(id self, SEL _cmd, Type value)
    {
        BMPropertyFinder finder(self);

        BMInternalPropertyTemplate<Type> *property = NULL;

        property = dynamic_cast<BMInternalPropertyTemplate<Type> *>(finder.findByMutator(_cmd));

        id boxedValue = property->box(value);
        BMInternalProperty::mutatorHook(&boxedValue, property, self);
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
