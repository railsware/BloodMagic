//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import <objc/runtime.h>

#import <string>

class RDInternalProperty {
    objc_AssociationPolicy _associationPolicy;
    std::string _propertyName;
public:
    objc_AssociationPolicy associationPolicy() const;
    void setAssociationPolicy(objc_AssociationPolicy policy);

    const std::string& propertyName() const;
    void setPropertyName(const std::string& propertyName);

    virtual ~RDInternalProperty();
    virtual IMP mutatorImplementation() = 0;
    virtual IMP accessorImplementation() = 0;
};
