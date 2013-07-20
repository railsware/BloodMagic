//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "RDInternalPropertyTemplate.h"

class RDPrimitiveLongLongProperty : public RDInternalPropertyTemplate<long long>
{
public:
    long long unbox(id value) override;
    id box(long long value) override;
};