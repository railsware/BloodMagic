//
// Created by Alex Denisov on 07.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

typedef id (^magic_initializer_t)(id sender);

#ifndef register_module

#define register_module(protocol, name) \
dynamic name; \
+ (void)protocol ## __ ## name {}

#endif