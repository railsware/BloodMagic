//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveUnsignedLongProperty.h"

unsigned long RDPrimitiveUnsignedLongProperty::unbox(id value) {
    return [value unsignedLongValue];
}

id RDPrimitiveUnsignedLongProperty::box(unsigned long value) {
    return @(value);
}