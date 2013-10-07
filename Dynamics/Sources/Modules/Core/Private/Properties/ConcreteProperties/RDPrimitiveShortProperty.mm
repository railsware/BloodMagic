//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveShortProperty.h"

short RDPrimitiveShortProperty::unbox(id value) {
    return [value shortValue];
}

id RDPrimitiveShortProperty::box(short value) {
    return @(value);
}