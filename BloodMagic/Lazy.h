//
// Created by Alex Denisov on 07.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import <BloodMagic/BMPublicCoreDefnitions.h>
#import <BloodMagic/BMLazy.h>
#import <BloodMagic/BMLazyExclude.h>
#import <BloodMagic/BMInitializer+LazyInitializer.h>
#import <BloodMagic/BMInitializerRegistry+LazyRegistry.h>
#import <BloodMagic/BMLazyDefinitions.h>

#ifndef bm_lazy
#define bm_lazy
#endif

#ifndef lazy
#define lazy(property_name) register_module(BMLazy, property_name)
#endif

#ifndef BMLazyProperty
#define BMLazyProperty register_property(BMLazy)
#endif
