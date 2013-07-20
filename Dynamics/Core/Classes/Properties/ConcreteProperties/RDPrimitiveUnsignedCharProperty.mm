//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveUnsignedCharProperty.h"

unsigned char RDPrimitiveUnsignedCharProperty::unbox(id value) {
    return [value unsignedCharValue];
}

id RDPrimitiveUnsignedCharProperty::box(unsigned char value) {
    return @(value);
}