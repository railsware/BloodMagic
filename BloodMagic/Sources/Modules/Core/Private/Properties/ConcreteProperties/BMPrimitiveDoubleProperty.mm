//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveDoubleProperty.h"

id BMPrimitiveDoubleProperty::box(double value) {
    return @(value);
}

double BMPrimitiveDoubleProperty::unbox(id value) {
    return [value doubleValue];
}