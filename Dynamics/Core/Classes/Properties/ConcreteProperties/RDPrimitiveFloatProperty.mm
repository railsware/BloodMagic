//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveFloatProperty.h"

float RDPrimitiveFloatProperty::unbox(id value) {
    return [value floatValue];
}

id RDPrimitiveFloatProperty::box(float value) {
    return @(value);
}