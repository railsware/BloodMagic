//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveDoubleProperty.h"

id RDPrimitiveDoubleProperty::box(double value) {
    return @(value);
}

double RDPrimitiveDoubleProperty::unbox(id value) {
    return [value doubleValue];
}