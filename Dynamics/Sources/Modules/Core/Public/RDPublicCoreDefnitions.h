//
// Created by Alex Denisov on 07.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#define rd_init(priority) __attribute__((constructor(priority)))

#define rd_core_init rd_init(50)
#define rd_user_init rd_init(100)

#define rd_module_initializer rd_core_init static void
#define rd_initializer rd_user_init static void

typedef id (^dynamics_initializer_t)(id sender);

