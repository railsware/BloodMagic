//
//  BMInjectableDefinitions.h
//  BloodMagic
//
//  Created by AlexDenisov on 8/7/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#pragma once

#define blood_magic_initializer __attribute__((constructor))

#define injectable_initializer blood_magic_initializer static void

#ifndef bm_injectable
#define bm_injectable
#endif

#ifndef injectable
#define injectable(property_name) register_module(BMInjectable, property_name)
#endif

#ifndef BMInjectableProperty
#define BMInjectableProperty register_property(BMInjectable)
#endif
