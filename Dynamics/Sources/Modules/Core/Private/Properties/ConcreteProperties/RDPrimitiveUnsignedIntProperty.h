//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveUnsignedIntProperty : public RDInternalPropertyTemplate<unsigned int>
{
public:
    unsigned int unbox(id value) override;
    id box(unsigned int value) override;
};