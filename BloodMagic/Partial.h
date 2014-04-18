//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import <BloodMagic/BMPublicCoreDefnitions.h>
#import <BloodMagic/BMPartial.h>

#ifndef bm_partial
#define bm_partial
#endif

#ifndef partial
#define partial(property_name) register_module(BMPartial, property_name)
#endif

#ifndef BMPartialProperty
#define BMPartialProperty register_property(BMPartial)
#endif
