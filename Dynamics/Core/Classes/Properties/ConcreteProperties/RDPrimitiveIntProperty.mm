//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveIntProperty.h"

int RDPrimitiveIntProperty::unbox(id value) {
    return [value intValue];
}

id RDPrimitiveIntProperty::box(int value) {
    return @(value);
}