//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveUnsignedCharProperty : public RDInternalPropertyTemplate<unsigned char>
{
public:
    unsigned char unbox(id value) override;
    id box(unsigned char value) override;
};