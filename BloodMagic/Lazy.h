//
// Created by Alex Denisov on 07.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import <BloodMagic/Sources/Modules/Core/Public/BMPublicCoreDefnitions.h>
#import <BloodMagic/Sources/Modules/Lazy/Public/BMLazy.h>
#import <BloodMagic/Sources/Modules/Lazy/Public/BMLazyExclude.h>
#import <BloodMagic/Sources/Modules/Lazy/Public/BMInitializer+LazyInitializer.h>
#import <BloodMagic/Sources/Modules/Lazy/Public/BMInitializerRegistry+LazyRegistry.h>
#import <BloodMagic/Sources/Modules/Lazy/Public/BMLazyDefinitions.h>

#ifndef bm_lazy
#define bm_lazy
#endif

#ifndef lazy
#define lazy(property_name) register_module(BMLazy, property_name)
#endif
