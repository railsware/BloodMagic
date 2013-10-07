//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveLongProperty : public RDInternalPropertyTemplate<long>
{
public:
    long unbox(id value) override;
    id box(long value) override;
};