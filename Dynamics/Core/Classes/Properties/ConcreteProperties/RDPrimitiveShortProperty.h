//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveShortProperty : public RDInternalPropertyTemplate<short>
{
public:
    short unbox(id value) override;
    id box(short value) override;
};