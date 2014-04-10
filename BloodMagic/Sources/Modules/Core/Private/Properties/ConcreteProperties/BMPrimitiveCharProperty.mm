//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveCharProperty.h"

char BMPrimitiveCharProperty::unbox(id value) {
    return [value charValue];
}

id BMPrimitiveCharProperty::box(char value) {
    return @(value);
}
