//
// Created by Alex Denisov on 22.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#include "BMPropertyFinder.h"
#include "BMProperty_Private.h"
#include "BMPropertyCollector.h"

BMPropertyFinder::BMPropertyFinder(id self) : _self(self)
{
    BMPropertyCollector *collector = [BMPropertyCollector collector];
    _properties = [collector collectForClass:[_self class] withProtocol:nil];
}

BMInternalProperty *BMPropertyFinder::findByAccessor(SEL cmd) const
{
    NSString *accessorName = NSStringFromSelector(cmd);
    for (BMProperty *p in _properties) {
        if ([p.accessor isEqualToString:accessorName]) {
            return p.internalProperty;
        }
    }

    return NULL;
}

BMInternalProperty *BMPropertyFinder::findByName(NSString *name) const
{
    for (BMProperty *p in _properties) {
        if ([p.name isEqualToString:name]) {
            return p.internalProperty;
        }
    }

    return NULL;
}

BMInternalProperty *BMPropertyFinder::findByMutator(SEL cmd) const
{
    NSString *mutatorName = NSStringFromSelector(cmd);
    for (BMProperty *p in _properties) {
        if ([p.mutator isEqualToString:mutatorName]) {
            return p.internalProperty;
        }
    }

    return NULL;
}
