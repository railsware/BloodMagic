//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveFloatProperty.h"

float BMPrimitiveFloatProperty::unbox(id value) {
    return [value floatValue];
}

id BMPrimitiveFloatProperty::box(float value) {
    return @(value);
}
