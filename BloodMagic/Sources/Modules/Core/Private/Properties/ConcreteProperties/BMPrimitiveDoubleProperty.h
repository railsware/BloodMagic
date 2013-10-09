//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMPrimitiveDoubleProperty : public BMInternalPropertyTemplate<double>
{
public:
    double unbox(id value) override;
    id box(double value) override;
};
