//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveUnsignedLongLongProperty.h"

unsigned long long RDPrimitiveUnsignedLongLongProperty::unbox(id value) {
    return [value unsignedLongLongValue];
}

id RDPrimitiveUnsignedLongLongProperty::box(unsigned long long value) {
    return @(value);
}