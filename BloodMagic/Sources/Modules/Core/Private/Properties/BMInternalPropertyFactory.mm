//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#include <objc/runtime.h>

#import "BMInternalPropertyFactory.h"
#import "BMInternalProperty.h"
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

@implementation BMInternalPropertyFactory

+ (BMInternalProperty *)newInternalPropertyFromType:(const char *)type
{
    if (type[0] == '@') {
        return [self compositeProperty:type];
    }
    return [self primitivePropertyFromType:type];
}

+ (BMInternalProperty *)compositeProperty:(const char *)type
{
    std::string className(type);
    className = className.substr(2, className.length() - 3);

    RDCompositeProperty *compositeProperty = new RDCompositeProperty;
    compositeProperty->setPropertyClassName(className);
    return compositeProperty;
}

+ (BMInternalProperty *)primitivePropertyFromType:(const char *)type
{
    BMInternalProperty *property = NULL;
    switch (type[0]) {
        case _C_CHR:{
            property = new RDPrimitiveCharProperty;
        } break;
        case _C_UCHR:{
            property = new RDPrimitiveUnsignedCharProperty;
        } break;
        case _C_SHT:{
            property = new RDPrimitiveShortProperty;
        } break;
        case _C_USHT:{
            return new RDPrimitiveUnsignedShortProperty;
        } break;
        case _C_INT:{
            property = new RDPrimitiveIntProperty;
        } break;
        case _C_UINT:{
            property = new RDPrimitiveUnsignedIntProperty;
        } break;
        case _C_LNG:{
            property = new RDPrimitiveLongProperty;
        } break;
        case _C_ULNG:{
            property = new RDPrimitiveUnsignedLongProperty;
        } break;
        case _C_LNG_LNG:{
            property = new RDPrimitiveLongLongProperty;
        } break;
        case _C_ULNG_LNG:{
            property = new RDPrimitiveUnsignedLongLongProperty;
        } break;
        case _C_FLT:{
            property = new RDPrimitiveFloatProperty;
        } break;
        case _C_DBL:{
            property = new RDPrimitiveDoubleProperty;
        } break;
        default:{
//            NSLog(@"Unknown property type '%s", type);
        };
    };
    if (property != NULL) {
        property->setPropertyClassName("NSNumber");
    }

    return property;
}

@end