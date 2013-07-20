//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveDoubleProperty : public RDInternalPropertyTemplate<double>
{
public:
    double unbox(id value) override;
    id box(double value) override;
};
