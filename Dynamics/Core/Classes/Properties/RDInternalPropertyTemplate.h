//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalProperty.h"
#import "RDProperty.h"
#import "RDProperty_Private.h"
#import "RDDefinitions.h"
#import <objc/runtime.h>

#include <iostream>

using namespace std;

template <class Type>
class RDInternalPropertyTemplate : public RDInternalProperty
{

    static Type accessorIMP(id self, SEL _cmd)
    {
        NSArray *properties = objc_getAssociatedObject([self class], kCachedPropertiesKey);
        RDInternalPropertyTemplate<Type> *internal = NULL;
        NSString *accessorName = NSStringFromSelector(_cmd);
        for (RDProperty *p in properties) {
            if ([p.accessor isEqualToString:accessorName]) {
                internal = dynamic_cast<RDInternalPropertyTemplate<Type> *>(p.internalProperty);
                break;
            }
        }
        id value = objc_getAssociatedObject(self, internal->propertyName().c_str());
        RDInternalProperty::beforeUnboxHook(&value, internal->propertyClassName());
        return internal->unbox(value);
    }

    static void mutatorIMP(id self, SEL _cmd, Type value)
    {
        NSArray *properties = objc_getAssociatedObject([self class], kCachedPropertiesKey);
        RDInternalPropertyTemplate<Type> *internal = NULL;
        NSString *mutatorName = NSStringFromSelector(_cmd);
        for (RDProperty *p in properties) {
            if ([p.mutator isEqualToString:mutatorName]) {
                internal = dynamic_cast<RDInternalPropertyTemplate<Type> *>(p.internalProperty);
                break;
            }
        }
        id boxedValue = internal->box(value);
        RDInternalProperty::afterBoxHook(&boxedValue, internal->propertyClassName());
        objc_setAssociatedObject(self, internal->propertyName().c_str(), boxedValue, internal->associationPolicy());
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
