//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class RDPrimitiveIntProperty : public BMInternalPropertyTemplate<int>
{
public:
    int unbox(id value) override;
    id box(int value) override;
};
