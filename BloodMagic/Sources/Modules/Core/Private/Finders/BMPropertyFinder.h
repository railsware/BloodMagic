//
// Created by Alex Denisov on 22.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

class BMInternalProperty;

class BMPropertyFinder
{
private:
    id _self;
    NSArray *_properties;

public:
    BMPropertyFinder(id self);
    BMInternalProperty *findByAccessor(SEL cmd) const;
    BMInternalProperty *findByMutator(SEL cmd) const;
    BMInternalProperty *findByName(NSString *name) const;
};
