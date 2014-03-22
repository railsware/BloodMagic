//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalProperty.h"
#import "BMPropertyFinder.h"
#import "BMPropertyValueService.h"
#import "BMProperty_Private.h"
#import "BMHook.h"

template <class Type>
class BMInternalPropertyTemplate : public BMInternalProperty
{
    static const int _accessorTypesLength;
    static const int _mutatorTypesLength;
    
    char _accessorTypes[_accessorTypesLength];
    char _mutatorTypes[_mutatorTypesLength];
    
    static Type accessorIMP(id self, SEL _cmd)
    {
        BMPropertyFinder finder(self);

        BMInternalPropertyTemplate<Type> *property = NULL;

        property = dynamic_cast<BMInternalPropertyTemplate<Type> *>(finder.findByAccessor(_cmd));
        
        id value = getValueForProperty(self, property->property());
        id<BMHook> hook = property->property().hook;
        [hook accessorHook:&value withProperty:property->property() sender:self];
        return property->unbox(value);
    }

    static void mutatorIMP(id self, SEL _cmd, Type value)
    {
        BMPropertyFinder finder(self);

        BMInternalPropertyTemplate<Type> *property = NULL;

        property = dynamic_cast<BMInternalPropertyTemplate<Type> *>(finder.findByMutator(_cmd));

        id boxedValue = property->box(value);
        
        id<BMHook> hook = property->property().hook;
        [hook mutatorHook:&boxedValue withProperty:property->property() sender:self];
        setValueForProperty(self, property->property(), boxedValue);
    }

public:
    BMInternalPropertyTemplate()
    {
        strcpy(_accessorTypes, @encode(Type));
        strcat(_accessorTypes, "@:");
        _accessorTypes[_accessorTypesLength - 1] = '\0';

        strcpy(_mutatorTypes, "v@:");
        strcpy(_mutatorTypes, @encode(Type));
        _mutatorTypes[_mutatorTypesLength - 1] = '\0';
    }
    
    IMP accessorImplementation()
    {
        return reinterpret_cast<IMP>(&accessorIMP);
    }
    IMP mutatorImplementation()
    {
        return reinterpret_cast<IMP>(&mutatorIMP);
    }

    const char *accessorTypes()
    {
        return _accessorTypes;
    }
    
    const char *mutatorTypes()
    {
        return _mutatorTypes;
    }
    
    virtual Type unbox(id value) = 0;
    virtual id box(Type value) = 0;
};

/*
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 
 t = Type
 */
template<class Type>
const int BMInternalPropertyTemplate<Type>::_accessorTypesLength = sizeof("t@:") + 1;

template<class Type>
const int BMInternalPropertyTemplate<Type>::_mutatorTypesLength = sizeof("v@:t") + 1;

