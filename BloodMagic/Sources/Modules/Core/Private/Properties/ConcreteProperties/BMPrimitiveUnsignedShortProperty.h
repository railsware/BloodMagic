//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMPrimitiveUnsignedShortProperty : public BMInternalPropertyTemplate<unsigned short>
{
public:
    unsigned short unbox(id value) override;
    id box(unsigned short value) override;
};
