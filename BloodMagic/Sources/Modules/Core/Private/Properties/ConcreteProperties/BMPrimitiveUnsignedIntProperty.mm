//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveUnsignedIntProperty.h"

unsigned int BMPrimitiveUnsignedIntProperty::unbox(id value) {
    return [value unsignedIntValue];
}

id BMPrimitiveUnsignedIntProperty::box(unsigned int value) {
    return @(value);
}
