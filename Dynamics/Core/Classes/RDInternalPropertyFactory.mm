//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDInternalPropertyFactory.h"
#import "RDInternalProperty.h"
#import "RDInternalPropertyTemplate.h"

#import "RDCompsiteProperty.h"
#import "RDPrimitiveCharProperty.h"
#import "RDPrimitiveUnsignedCharProperty.h"
#import "RDPrimitiveShortProperty.h"
#import "RDPrimitiveUnsignedShortProperty.h"
#import "RDPrimitiveIntProperty.h"
#import "RDPrimitiveUnsignedIntProperty.h"
#import "RDPrimitiveLongProperty.h"
#import "RDPrimitiveUnsignedLongProperty.h"
#import "RDPrimitiveLongLongProperty.h"
#import "RDPrimitiveUnsignedLongLongProperty.h"
#import "RDPrimitiveFloatProperty.h"
#import "RDPrimitiveDoubleProperty.h"

@implementation RDInternalPropertyFactory

+ (RDInternalProperty *)newInternalPropertyFromType:(const char *)type
{
    if (type[0] == '@') {
        return [self compositeProperty];
    }
    return [self primitivePropertyFromType:type];
}

+ (RDInternalProperty *)compositeProperty
{
    return new RDCompositeProperty;
}

+ (RDInternalProperty *)primitivePropertyFromType:(const char *)type
{
    switch (type[0]) {
        case _C_CHR:{
            return new RDPrimitiveCharProperty;
        } break;
        case _C_UCHR:{
            return new RDPrimitiveUnsignedCharProperty;
        } break;
        case _C_SHT:{
            return new RDPrimitiveShortProperty;
        } break;
        case _C_USHT:{
            return new RDPrimitiveUnsignedShortProperty;
        } break;
        case _C_INT:{
            return new RDPrimitiveIntProperty;
        } break;
        case _C_UINT:{
            return new RDPrimitiveUnsignedIntProperty;
        } break;
        case _C_LNG:{
            return new RDPrimitiveLongProperty;
        } break;
        case _C_ULNG:{
            return new RDPrimitiveUnsignedLongProperty;
        } break;
        case _C_LNG_LNG:{
            return new RDPrimitiveLongLongProperty;
        } break;
        case _C_ULNG_LNG:{
            return new RDPrimitiveUnsignedLongLongProperty;
        } break;
        case _C_FLT:{
            return new RDPrimitiveFloatProperty;
        } break;
        case _C_DBL:{
            return new RDPrimitiveDoubleProperty;
        } break;
        default:{
            NSLog(@"Unknown property type '%s", type);
        };
    };
    return NULL;
}

@end