//
//  Final.h
//  BloodMagic
//
//  Created by AlexDenisov on 2/6/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import <BloodMagic/BMPublicCoreDefnitions.h>
#import <BloodMagic/BMFinal.h>

#ifndef bm_final
#define bm_final
#endif

#ifndef final
#define final(property_name) register_module(BMFinal, property_name) 
#endif

#ifndef BMFinalProperty
#define BMFinalProperty register_property(BMFinal)
#endif
