//
// Created by Alex Denisov on 22.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#include "BMPropertyFinder.h"
#include "BMProperty_Private.h"
#include "BMPrivateCoreDefinitions.h"

BMPropertyFinder::BMPropertyFinder(id self) : _self(self)
{
}

NSArray *BMPropertyFinder::properties() const
{
    NSArray *properties = nil;
    Class klass = [_self class];
    while (klass != [NSObject class]) {
        properties = objc_getAssociatedObject(klass, kCachedPropertiesKey);
        if (properties) {
            break;
        }
        klass = [klass superclass];
    }

    return properties;
}

BMInternalProperty *BMPropertyFinder::findByAccessor(SEL cmd) const
{
    NSString *accessorName = NSStringFromSelector(cmd);
    for (BMProperty *p in this->properties()) {
        if ([p.accessor isEqualToString:accessorName]) {
            return p.internalProperty;
        }
    }

    return NULL;
}

BMInternalProperty *BMPropertyFinder::findByName(NSString *name) const
{
    for (BMProperty *p in this->properties()) {
        if ([p.name isEqualToString:name]) {
            return p.internalProperty;
        }
    }

    return NULL;
}

BMInternalProperty *BMPropertyFinder::findByMutator(SEL cmd) const
{
    NSString *mutatorName = NSStringFromSelector(cmd);
    for (BMProperty *p in this->properties()) {
        if ([p.mutator isEqualToString:mutatorName]) {
            return p.internalProperty;
        }
    }

    return NULL;
}
