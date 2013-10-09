//
// Created by Alex Denisov on 08.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#define blood_magic_initializer __attribute__((constructor))

#define lazy_initializer blood_magic_initializer static void
