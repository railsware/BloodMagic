//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveUnsignedLongProperty : public RDInternalPropertyTemplate<unsigned long>
{
public:
    unsigned long unbox(id value) override;
    id box(unsigned long value) override;
};