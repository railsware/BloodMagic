//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveCharProperty.h"

char RDPrimitiveCharProperty::unbox(id value) {
    return [value charValue];
}

id RDPrimitiveCharProperty::box(char value) {
    return @(value);
}