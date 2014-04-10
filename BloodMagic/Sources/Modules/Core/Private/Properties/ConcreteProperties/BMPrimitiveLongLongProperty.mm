//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveLongLongProperty.h"

long long BMPrimitiveLongLongProperty::unbox(id value) {
    return [value longLongValue];
}

id BMPrimitiveLongLongProperty::box(long long value) {
    return @(value);
}
