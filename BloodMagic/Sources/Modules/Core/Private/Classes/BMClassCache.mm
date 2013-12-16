//
//  BMClassCache.m
//  BloodMagic
//
//  Created by AlexDenisov on 12/16/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import "BMClassCache.h"

#include <map>

@implementation BMClassCache
{
    std::map<NSUInteger, id> _cachedClasses;
}

+ (instancetype)cache
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (BMClass *)internalClassForObjCClass:(Class)objcClass
{
    NSUInteger classKey = (NSUInteger)objcClass;
    return _cachedClasses[classKey];
}

- (void)setInternalClass:(BMClass *)internalClass forObjCClass:(Class)objcClass
{
    NSUInteger classKey = (NSUInteger)objcClass;
    _cachedClasses[classKey] = internalClass;
}

@end
