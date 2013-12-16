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
//    NSMutableDictionary *_cachedProperties;
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
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _cachedProperties = [NSMutableDictionary new];
//    }
//    
//    return self;
//}

- (property_list_t)collectForClass:(Class)objcClass withProtocol:(Protocol *)protocol
{
    return [self collectForClass:objcClass withProtocol:protocol excludingProtocol:nil];
}

- (property_list_t)collectForClass:(Class)objcClass withProtocol:(Protocol *)protocol excludingProtocol:(Protocol *)excludingProtocol
{
    NSUInteger classKey = (NSUInteger)objcClass;
//    NSString *className = NSStringFromClass(objcClass);
    property_list_t cachedProperties = _cachedProperties[classKey];
    
    if (!cachedProperties.empty()) {
        return cachedProperties;
    }

//    NSMutableSet *properties = [NSMutableSet new];
    Class superClass = objcClass;
    while ([superClass conformsToProtocol:protocol]) {
        BMClass *klass =  [BMClass classWithObjCClass:superClass];
        BOOL isExcludedClass = [[klass protocols] containsObject:excludingProtocol];
        if (!isExcludedClass) {
            for (BMProperty *property in [klass dynamicProperties]) {
                cachedProperties.push_back(property);
            }
//            [properties unionSet:[klass dynamicProperties]];
        }

        superClass = [superClass superclass];
    }

//    NSArray *result = [properties allObjects];
    
    _cachedProperties[classKey] = cachedProperties;
    
    return cachedProperties;
}

@end