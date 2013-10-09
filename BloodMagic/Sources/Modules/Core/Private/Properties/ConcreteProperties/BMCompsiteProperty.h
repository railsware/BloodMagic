//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMCompositeProperty : public BMInternalPropertyTemplate<id>
{
public:
    __strong id unbox(id value) override;
    id box(id value) override;
};
