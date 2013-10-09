//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class RDPrimitiveLongLongProperty : public BMInternalPropertyTemplate<long long>
{
public:
    long long unbox(id value) override;
    id box(long long value) override;
};