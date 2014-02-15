//
// Created by Alex Denisov on 07.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

typedef id (^magic_initializer_t)(id sender);

#ifndef BM_UNAVAILABLE

    #if __has_extension(attribute_unavailable_with_message)
        #define BM_UNAVAILABLE(MSG) __attribute__((unavailable(MSG)))
    #elif __has_extension(attribute_unavailable)
        #define BM_UNAVAILABLE(MSG) __attribute__((unavailable))
    #else
        #define BM_UNAVAILABLE(MSG)
    #endif

#endif

#ifndef register_module

#define register_module(protocol, name) \
dynamic name; \
+ (void)protocol ## __ ## name BM_UNAVAILABLE("BloodMagic's empty method") {}

#endif
