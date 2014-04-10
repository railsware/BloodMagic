//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveUnsignedCharProperty.h"

unsigned char BMPrimitiveUnsignedCharProperty::unbox(id value) {
    return [value unsignedCharValue];
}

id BMPrimitiveUnsignedCharProperty::box(unsigned char value) {
    return @(value);
}
