//
// Created by Alex Denisov on 15.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMPropertyCollector.h"
#import "BMClassCollector.h"
#import "BMClass.h"
#import "BMProperty_Private.h"
#import "BMHook.h"

static inline id hookForProtocol(Protocol *protocol)
{
    id hook = nil;
    class_list_t *totalHooks = [[BMClassCollector collector] collectForProtocol:@protocol(BMHook)];
    
    for (auto klass : *totalHooks) {
        if (class_conformsToProtocol(klass, protocol)) {
            hook = klass;
            break;
        }
    }
    
    return hook;
}

static inline void updateProperties(property_list_t *properties, Protocol *protocol, Class superClass)
{
    if (!protocol) {
        return;
    }
    
    id hook = hookForProtocol(protocol);
    NSString *protocolName = NSStringFromProtocol(protocol);
    
    for (BMProperty *property : *properties) {
        NSString *propertySelectorName = [NSString stringWithFormat:@"%@__%@",
                                          protocolName,
                                          property.name];
        SEL propertySelector = NSSelectorFromString(propertySelectorName);
        BOOL isProbableHook = ![superClass respondsToSelector:propertySelector];
        if (isProbableHook) {
            [property setProbableHook:hook];
        } else {
            [property setHook:hook];
        }
    }
}

@implementation BMPropertyCollector
{
    property_list_map_t _cachedProperties;
}

+ (instancetype)collector
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)dealloc
{
    for (auto it = _cachedProperties.cbegin(); it != _cachedProperties.cend();) {
        property_list_map_t::iterator removeIt = _cachedProperties.erase(it++);
        delete (*removeIt).second;
    }
}

- (property_list_t *)collectForClass:(Class)objcClass withProtocol:(Protocol *)protocol
{
    return [self collectForClass:objcClass withProtocol:protocol excludingProtocol:nil];
}

- (property_list_t *)collectForClass:(Class)objcClass
                        withProtocol:(Protocol *)protocol
                   excludingProtocol:(Protocol *)excludingProtocol
{
    NSUInteger classKey = (NSUInteger)objcClass;
    property_list_t *cachedProperties = _cachedProperties[classKey];
    
    if (cachedProperties && !cachedProperties->empty()) {
        updateProperties(cachedProperties, protocol, objcClass);
        return cachedProperties;
    }

    cachedProperties = new property_list_t;

    BMClass *klass =  [BMClass classWithObjCClass:objcClass andProtocol:protocol excludingProtocol:excludingProtocol];
    for (BMProperty *property in [klass dynamicProperties]) {
        cachedProperties->push_back(property);
    }

    _cachedProperties[classKey] = cachedProperties;
    
    updateProperties(cachedProperties, protocol, objcClass);
    
    return cachedProperties;
}

@end
