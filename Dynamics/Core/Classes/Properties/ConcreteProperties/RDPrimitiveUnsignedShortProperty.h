//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveUnsignedShortProperty : public RDInternalPropertyTemplate<unsigned short>
{
public:
    unsigned short unbox(id value) override;
    id box(unsigned short value) override;
};
