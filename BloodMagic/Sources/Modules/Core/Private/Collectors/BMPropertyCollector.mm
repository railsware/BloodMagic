//
// Created by Alex Denisov on 15.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <objc/runtime.h>
#import "BMPropertyCollector.h"
#import "BMClass.h"
#import "BMProperty.h"

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

- (property_list_t *)collectForClass:(Class)objcClass withProtocol:(Protocol *)protocol excludingProtocol:(Protocol *)excludingProtocol
{
    NSUInteger classKey = (NSUInteger)objcClass;
    property_list_t *cachedProperties = _cachedProperties[classKey];
    
    if (cachedProperties && !cachedProperties->empty()) {
        return cachedProperties;
    }
    
    cachedProperties = new property_list_t;

    Class superClass = objcClass;
    while ([superClass conformsToProtocol:protocol]) {
        BMClass *klass =  [BMClass classWithObjCClass:superClass];
        BOOL isExcludedClass = [[klass protocols] containsObject:excludingProtocol];
        if (!isExcludedClass) {
            for (BMProperty *property in [klass dynamicProperties]) {
                cachedProperties->push_back(property);
            }
        }

        superClass = [superClass superclass];
    }
    _cachedProperties[classKey] = cachedProperties;
    
    return cachedProperties;
}

@end