//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMPrimitiveShortProperty.h"

short BMPrimitiveShortProperty::unbox(id value) {
    return [value shortValue];
}

id BMPrimitiveShortProperty::box(short value) {
    return @(value);
}
