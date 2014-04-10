//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMPrimitiveUnsignedLongProperty : public BMInternalPropertyTemplate<unsigned long>
{
public:
    unsigned long unbox(id value) override;
    id box(unsigned long value) override;
};
