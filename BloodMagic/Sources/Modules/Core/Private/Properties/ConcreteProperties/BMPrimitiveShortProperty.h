//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMPrimitiveShortProperty : public BMInternalPropertyTemplate<short>
{
public:
    short unbox(id value) override;
    id box(short value) override;
};
