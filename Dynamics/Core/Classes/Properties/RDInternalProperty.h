//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import <objc/runtime.h>
#import <string>

@class RDProperty;

class RDInternalProperty {
    objc_AssociationPolicy _associationPolicy;
    std::string _propertyName;
    std::string _propertyClassName;
    __weak RDProperty *_property;
public:
    objc_AssociationPolicy associationPolicy() const;
    void setAssociationPolicy(objc_AssociationPolicy policy);

    const std::string& propertyName() const;
    void setPropertyName(const std::string& propertyName);

    const std::string &propertyClassName() const;
    void setPropertyClassName(const std::string &propertyClassName);

    const RDProperty *property() const;
    void setProperty(RDProperty *property);

    virtual ~RDInternalProperty();
    virtual IMP mutatorImplementation() = 0;
    virtual IMP accessorImplementation() = 0;

    static void mutatorHook(id *value, const RDInternalProperty *internal, id sender);
    static void accessorHook(id *value, const RDInternalProperty *internal, id sender);

};
