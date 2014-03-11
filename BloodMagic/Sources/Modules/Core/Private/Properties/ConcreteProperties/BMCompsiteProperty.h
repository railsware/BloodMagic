//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "BMInternalPropertyTemplate.h"

class BMCompositeProperty : public BMInternalPropertyTemplate<id>
{
public:
   
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wignored-qualifiers"
    __strong id unbox(id value) override;
#pragma clang diagnostic pop
   
    id box(id value) override;
};
