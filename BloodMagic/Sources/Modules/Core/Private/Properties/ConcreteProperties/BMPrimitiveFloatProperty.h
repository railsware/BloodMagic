//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMPrimitiveFloatProperty : public BMInternalPropertyTemplate<float>
{
public:
    float unbox(id value) override;
    id box(float value) override;
};
