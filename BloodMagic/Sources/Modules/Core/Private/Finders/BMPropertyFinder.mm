//
// Created by Alex Denisov on 22.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#include "BMPropertyFinder.h"
#include "BMProperty_Private.h"
#include "BMPropertyCollector.h"

BMPropertyFinder::BMPropertyFinder(id self)
{
    BMPropertyCollector *collector = [BMPropertyCollector collector];
    _properties = [collector collectForClass:[self class] withProtocol:nil];
}

BMInternalProperty *BMPropertyFinder::findByAccessor(SEL cmd) const
{
    for (auto it = _properties->cbegin(); it != _properties->cend(); it++) {
        BMProperty *p = *it;
        if (p.accessorSelector == cmd) {
            return p.internalProperty;
        }
    }

    return NULL;
}

BMInternalProperty *BMPropertyFinder::findByName(NSString *name) const
{
    for (auto it = _properties->cbegin(); it != _properties->cend(); it++) {
        BMProperty *p = *it;
        if ([p.name isEqualToString:name]) {
            return p.internalProperty;
        }
    }

    return NULL;
}

BMInternalProperty *BMPropertyFinder::findByMutator(SEL cmd) const
{
    for (auto it = _properties->cbegin(); it != _properties->cend(); it++) {
        BMProperty *p = *it;
        if (p.mutatorSelector == cmd) {
            return p.internalProperty;
        }
    }

    return NULL;
}
