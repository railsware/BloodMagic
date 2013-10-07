//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveLongProperty.h"

long RDPrimitiveLongProperty::unbox(id value) {
    return [value longValue];
}

id RDPrimitiveLongProperty::box(long value) {
    return @(value);
}