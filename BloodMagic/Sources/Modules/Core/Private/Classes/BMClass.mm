//
//  BMClass.m
//  BloodMagic
//
//  Created by Eugene Solodovnykov on 30/10/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMClass_Private.h"
#import "BMProperty.h"
#import "BMProperty_Private.h"
#import "BMClassCache.h"

@implementation BMClass
{
    Class _objcClass;
    Protocol *_protocol;
    Protocol *_excludingProtocol;

    NSSet *_protocols;
    NSSet *_properties;
    NSSet *_dynamicProperties;
}

+ (instancetype)classWithObjCClass:(Class)objcClass
                       andProtocol:(Protocol *)protocol
                 excludingProtocol:(Protocol *)excluding
{
    BMClassCache *cache = [BMClassCache cache];
    BMClass *internalClass = [cache internalClassForObjCClass:objcClass];
    if (!internalClass) {
        internalClass = [[BMClass alloc] initWithClass:objcClass andProtocol:protocol excludingProtocol:excluding];
        [cache setInternalClass:internalClass forObjCClass:objcClass];
    }
    
    return internalClass;
}

- (instancetype)initWithClass:(Class)objcClass
                  andProtocol:(Protocol *)protocol
            excludingProtocol:(Protocol *)excluding
{
    self = [super init];
    _protocol = protocol;
    _objcClass = objcClass;
    _excludingProtocol = excluding;
    return self;
}

- (Class)objcClass
{
    return _objcClass;
}

- (NSSet *)protocols {
    if (!_protocols) {
        Protocol *__unsafe_unretained *protocols;
        uint protocolsCount = 0;
        protocols = class_copyProtocolList(_objcClass, &protocolsCount);
        NSMutableSet *mutableProtocols = [NSMutableSet setWithCapacity:protocolsCount];
        for (uint protocolIndex = 0; protocolIndex != protocolsCount; ++protocolIndex) {
            Protocol *protocol = protocols[protocolIndex];
            [mutableProtocols addObject:protocol];
        }
        free(protocols);
        _protocols = [NSSet setWithSet:mutableProtocols];
    }
    return _protocols;
}

- (NSSet *)properties {
    if (!_properties) {
        Class _class = _objcClass;
        NSMutableSet *mutableProperties = [NSMutableSet set];
        while (true) {
            if (![_class conformsToProtocol:_protocol]) {
                break;
            }
            
            if (class_conformsToProtocol(_class, _excludingProtocol)) {
                _class = class_getSuperclass(_class);
                continue;
            }

            objc_property_t *objcProperties;
            uint propertiesCount = 0;
            objcProperties = class_copyPropertyList(_class, &propertiesCount);
            for (uint propertyIndex = 0; propertyIndex != propertiesCount; ++propertyIndex) {
                objc_property_t objcProperty = objcProperties[propertyIndex];
                BMProperty *property = [[BMProperty alloc] initWithProperty:objcProperty ofClass:self];
                [mutableProperties addObject:property];
            }
            free(objcProperties);
            _class = class_getSuperclass(_class);
        }
        _properties = [NSSet setWithSet:mutableProperties];
    }
    return _properties;
}

- (NSSet *)dynamicProperties
{
    if (_dynamicProperties) {
        return _dynamicProperties;
    }

    NSSet *properties = [self properties];
    NSMutableSet *mutableProperties = [NSMutableSet setWithCapacity:properties.count];
    for (BMProperty *property in properties) {
        if (property.isDynamic) {
            [mutableProperties addObject:property];
        }
    }
    _dynamicProperties = [NSSet setWithSet:mutableProperties];

    return _dynamicProperties;
}

@end
