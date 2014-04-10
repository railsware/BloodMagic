//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveIntProperty.h"

int BMPrimitiveIntProperty::unbox(id value) {
    return [value intValue];
}

id BMPrimitiveIntProperty::box(int value) {
    return @(value);
}
