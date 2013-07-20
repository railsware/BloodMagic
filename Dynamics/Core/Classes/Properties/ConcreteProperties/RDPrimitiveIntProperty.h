//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveIntProperty : public RDInternalPropertyTemplate<int>
{
public:
    int unbox(id value) override;
    id box(int value) override;
};
