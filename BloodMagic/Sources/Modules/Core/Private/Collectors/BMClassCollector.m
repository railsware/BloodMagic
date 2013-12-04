//
// Created by Alex Denisov on 12.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMClassCollector.h"

@implementation BMClassCollector
{
    NSArray *_cachedClasses;
    NSMutableDictionary *_cachedClassesForProtocol;
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
    [self collectClasses];
    _cachedClassesForProtocol = [NSMutableDictionary new];
    
    return self;
}

- (void)collectClasses
{
    Class parentClass = NSClassFromString(@"NSObject");
    int numClasses = objc_getClassList(NULL, 0);
    Class classes[sizeof(Class) * numClasses];
    numClasses = objc_getClassList(classes, numClasses);
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++) {
        Class superClass = classes[i];
        do {
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != parentClass);
        
        if (superClass == nil) {
            continue;
        }
        
        Class klass = classes[i];
        
        if (class_getName(klass)[0] == '_') {
            continue;
        }
        
        [result addObject:klass];
    }
    _cachedClasses = [NSArray arrayWithArray:result];
}

- (NSArray *)collectForProtocol:(Protocol *)protocol
{
    NSString *protocolName = NSStringFromProtocol(protocol);
    NSArray *collectedClasses = _cachedClassesForProtocol[protocolName];
    
    if (collectedClasses) {
        return collectedClasses;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (Class klass in _cachedClasses) {
        if (![klass conformsToProtocol:protocol]) {
            continue;
        }

        [result addObject:klass];
    }
    
    NSArray *immutableResult = [NSArray arrayWithArray:result];
    _cachedClassesForProtocol[protocolName] = immutableResult;
    
    return immutableResult;
}

@end