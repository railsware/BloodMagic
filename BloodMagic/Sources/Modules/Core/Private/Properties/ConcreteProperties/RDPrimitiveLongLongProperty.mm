//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "RDPrimitiveLongLongProperty.h"

long long RDPrimitiveLongLongProperty::unbox(id value) {
    return [value longLongValue];
}

id RDPrimitiveLongLongProperty::box(long long value) {
    return @(value);
}