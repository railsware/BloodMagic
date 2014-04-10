//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMPrimitiveUnsignedLongLongProperty : public BMInternalPropertyTemplate<unsigned long long>
{
public:
    unsigned long long unbox(id value) override;
    id box(unsigned long long value) override;
};
