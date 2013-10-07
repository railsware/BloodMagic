//
// Created by Alex Denisov on 22.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

class RDInternalProperty;

class RDPropertyFinder
{
private:
    id _self;

private:
    NSArray *properties() const;

public:
    RDPropertyFinder(id self);
    RDInternalProperty *findByAccessor(SEL cmd) const;
    RDInternalProperty *findByMutator(SEL cmd) const;
    RDInternalProperty *findByName(NSString *name) const;
};
