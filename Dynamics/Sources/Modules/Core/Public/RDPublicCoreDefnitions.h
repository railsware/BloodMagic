//
// Created by Alex Denisov on 07.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#define rd_init(priority) __attribute__((constructor(priority)))

#define rd_initializer rd_init(100) static void

typedef id (^dynamics_initializer_t)(id sender);

