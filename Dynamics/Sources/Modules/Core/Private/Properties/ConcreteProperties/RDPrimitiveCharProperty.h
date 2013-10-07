//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveCharProperty : public RDInternalPropertyTemplate<char>
{
public:
    char unbox(id value) override;
    id box(char value) override;
};
