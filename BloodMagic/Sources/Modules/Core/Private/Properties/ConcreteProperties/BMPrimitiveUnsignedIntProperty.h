//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMPrimitiveUnsignedIntProperty : public BMInternalPropertyTemplate<unsigned int>
{
public:
    unsigned int unbox(id value) override;
    id box(unsigned int value) override;
};
