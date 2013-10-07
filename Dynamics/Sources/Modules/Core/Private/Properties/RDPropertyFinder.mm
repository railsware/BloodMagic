//
// Created by Alex Denisov on 22.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#include "RDPropertyFinder.h"
#include "RDProperty_Private.h"
#include "RDPrivateCoreDefinitions.h"

RDPropertyFinder::RDPropertyFinder(id self) : _self(self)
{
}

NSArray *RDPropertyFinder::properties() const
{
    NSArray *properties = objc_getAssociatedObject([_self class], kCachedPropertiesKey);

    return properties;
}

RDInternalProperty *RDPropertyFinder::findByAccessor(SEL cmd) const
{
    NSString *accessorName = NSStringFromSelector(cmd);
    for (RDProperty *p in this->properties()) {
        if ([p.accessor isEqualToString:accessorName]) {
            return p.internalProperty;
        }
    }

    return NULL;
}

RDInternalProperty *RDPropertyFinder::findByName(NSString *name) const
{
    for (RDProperty *p in this->properties()) {
        if ([p.name isEqualToString:name]) {
            return p.internalProperty;
        }
    }

    return NULL;
}

RDInternalProperty *RDPropertyFinder::findByMutator(SEL cmd) const
{
    NSString *mutatorName = NSStringFromSelector(cmd);
    for (RDProperty *p in this->properties()) {
        if ([p.mutator isEqualToString:mutatorName]) {
            return p.internalProperty;
        }
    }

    return NULL;
}
