//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveUnsignedLongLongProperty.h"

unsigned long long BMPrimitiveUnsignedLongLongProperty::unbox(id value) {
    return [value unsignedLongLongValue];
}

id BMPrimitiveUnsignedLongLongProperty::box(unsigned long long value) {
    return @(value);
}
