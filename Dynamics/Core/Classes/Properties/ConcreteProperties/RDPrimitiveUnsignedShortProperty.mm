//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveUnsignedShortProperty.h"

unsigned short RDPrimitiveUnsignedShortProperty::unbox(id value) {
    return [value unsignedShortValue];
}

id RDPrimitiveUnsignedShortProperty::box(unsigned short value) {
    return @(value);
}