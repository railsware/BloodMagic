//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#include "BMCompsiteProperty.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wignored-qualifiers"
__strong id BMCompositeProperty::unbox(id value) {
    return value;
}
#pragma clang diagnostic pop

id BMCompositeProperty::box(id value) {
    return value;
}

