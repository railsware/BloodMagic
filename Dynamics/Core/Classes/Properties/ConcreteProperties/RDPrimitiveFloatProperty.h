//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveFloatProperty : public RDInternalPropertyTemplate<float>
{
public:
    float unbox(id value) override;
    id box(float value) override;
};