//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveUnsignedShortProperty.h"

unsigned short BMPrimitiveUnsignedShortProperty::unbox(id value) {
    return [value unsignedShortValue];
}

id BMPrimitiveUnsignedShortProperty::box(unsigned short value) {
    return @(value);
}
