//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveLongProperty.h"

long BMPrimitiveLongProperty::unbox(id value) {
    return [value longValue];
}

id BMPrimitiveLongProperty::box(long value) {
    return @(value);
}
