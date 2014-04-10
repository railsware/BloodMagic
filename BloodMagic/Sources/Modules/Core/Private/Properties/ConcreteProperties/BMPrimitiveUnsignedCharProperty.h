//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMPrimitiveUnsignedCharProperty : public BMInternalPropertyTemplate<unsigned char>
{
public:
    unsigned char unbox(id value) override;
    id box(unsigned char value) override;
};
