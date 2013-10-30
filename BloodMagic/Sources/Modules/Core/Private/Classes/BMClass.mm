//
//  BMClass.m
//  BloodMagic
//
//  Created by Eugene Solodovnykov on 30/10/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMClass.h"
#import "BMProperty.h"

@implementation BMClass {
    Class _objcClass;

    NSSet *_protocols;
    NSSet *_properties;
}

- (instancetype)initWithClass:(Class)objcClass {
    self = [super init];
    _objcClass = objcClass;
    return self;
}

- (NSSet *)protocols {
    if (!_protocols) {
        Protocol *__unsafe_unretained *protocols;
        uint protocolsCount = 0;
        protocols = class_copyProtocolList(_objcClass, &protocolsCount);
        NSMutableSet *mutableProtocols = [NSMutableSet setWithCapacity:protocolsCount];
        for (int protocolIndex = 0; protocolIndex < protocolsCount; protocolIndex++) {
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
        objc_property_t *objcProperties;
        uint propertiesCount = 0;
        objcProperties = class_copyPropertyList(_objcClass, &propertiesCount);
        NSMutableSet *mutableProperties = [NSMutableSet setWithCapacity:propertiesCount];
        for (int propertyIndex = 0; propertyIndex < propertiesCount; propertyIndex++) {
            objc_property_t objcProperty = objcProperties[propertyIndex];
            BMProperty *property = [[BMProperty alloc] initWithProperty:objcProperty ofClass:_objcClass];
            [mutableProperties addObject:property];
        }
        free(objcProperties);
        _properties = [NSSet setWithSet:mutableProperties];
    }
    return _properties;
}

@end
