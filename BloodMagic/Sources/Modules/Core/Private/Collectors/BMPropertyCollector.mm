//
// Created by Alex Denisov on 15.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <objc/runtime.h>
#import "BMPropertyCollector.h"
#import "BMClass.h"

@implementation BMPropertyCollector
{
    NSMutableDictionary *_cachedProperties;
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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cachedProperties = [NSMutableDictionary new];
    }
    
    return self;
}

- (NSArray *)collectForClass:(Class)objcClass withProtocol:(Protocol *)protocol
{
    return [self collectForClass:objcClass withProtocol:protocol excludingProtocol:nil];
}

- (NSArray *)collectForClass:(Class)objcClass withProtocol:(Protocol *)protocol excludingProtocol:(Protocol *)excludingProtocol
{
    NSString *className = NSStringFromClass(objcClass);
    NSArray *cachedProperties = _cachedProperties[className];
    
    if (cachedProperties) {
        return cachedProperties;
    }

    NSMutableSet *properties = [NSMutableSet new];
    Class superClass = objcClass;
    while ([superClass conformsToProtocol:protocol]) {
        BMClass *klass = [[BMClass alloc] initWithClass:superClass];
        BOOL isExcludedClass = [[klass protocols] containsObject:excludingProtocol];
        if (!isExcludedClass) {
            [properties unionSet:[klass dynamicProperties]];
        }

        superClass = [superClass superclass];
    }

    NSArray *result = [properties allObjects];
    
    _cachedProperties[className] = result;
    
    return result;
}

@end