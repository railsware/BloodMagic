//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveUnsignedLongProperty.h"

unsigned long BMPrimitiveUnsignedLongProperty::unbox(id value) {
    return [value unsignedLongValue];
}

id BMPrimitiveUnsignedLongProperty::box(unsigned long value) {
    return @(value);
}
