//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveUnsignedIntProperty.h"

unsigned int RDPrimitiveUnsignedIntProperty::unbox(id value) {
    return [value unsignedIntValue];
}

id RDPrimitiveUnsignedIntProperty::box(unsigned int value) {
    return @(value);
}