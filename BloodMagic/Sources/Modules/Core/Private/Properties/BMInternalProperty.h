//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import <objc/runtime.h>
#import <string>

@class BMProperty;

class BMInternalProperty
{
    objc_AssociationPolicy _associationPolicy;
    std::string _propertyName;
    std::string _propertyClassName;
    __weak BMProperty *_property;
public:
    objc_AssociationPolicy associationPolicy() const;
    void setAssociationPolicy(objc_AssociationPolicy policy);

    const std::string& propertyName() const;
    void setPropertyName(const std::string& propertyName);

    const std::string &propertyClassName() const;
    void setPropertyClassName(const std::string &propertyClassName);

    const BMProperty *property() const;
    void setProperty(BMProperty *property);

    virtual ~BMInternalProperty();
    virtual IMP mutatorImplementation() = 0;
    virtual IMP accessorImplementation() = 0;

    static void mutatorHook(id *value, const BMInternalProperty *internal, id sender);
    static void accessorHook(id *value, const BMInternalProperty *internal, id sender);

};
