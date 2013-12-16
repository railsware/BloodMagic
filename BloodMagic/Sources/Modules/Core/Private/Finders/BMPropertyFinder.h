//
// Created by Alex Denisov on 22.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#include "BMInternalTypes.h"

class BMInternalProperty;

class BMPropertyFinder
{
private:
    id _self;
    property_list_t _properties;

public:
    BMPropertyFinder(id self);
    BMInternalProperty *findByAccessor(SEL cmd) const;
    BMInternalProperty *findByMutator(SEL cmd) const;
    BMInternalProperty *findByName(NSString *name) const;
};
