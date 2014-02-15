//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import <BloodMagic/Sources/Modules/Core/Public/BMPublicCoreDefnitions.h>
#import <BloodMagic/Sources/Modules/Partial/Public/BMPartial.h>

#ifndef bm_partial
#define bm_partial
#endif

#ifndef partial
#define partial(property_name) register_module(BMPartial, property_name)
#endif
