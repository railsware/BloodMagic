//
// Created by Alex Denisov on 08.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#define dynamic_initializer __attribute__((constructor))

#define lazy_initializer dynamic_initializer static void
