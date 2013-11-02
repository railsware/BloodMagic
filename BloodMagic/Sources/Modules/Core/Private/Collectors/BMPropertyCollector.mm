//
// Created by Alex Denisov on 15.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <objc/runtime.h>
#import "BMPropertyCollector.h"
#import "BMPrivateCoreDefinitions.h"
#import "BMClass.h"

@implementation BMPropertyCollector

- (NSArray *)collectForClass:(Class)objcClass withProtocol:(Protocol *)protocol
{
    NSArray *cachedProperties = objc_getAssociatedObject(objcClass, kCachedPropertiesKey);
    if (cachedProperties != nil) {
        return cachedProperties;
    }

    NSMutableSet *properties = [NSMutableSet new];
    Class superClass = objcClass;
    while ([superClass conformsToProtocol:protocol]) {
        BMClass *klass = [[BMClass alloc] initWithClass:superClass];
        [properties unionSet:[klass dynamicProperties]];

        superClass = [superClass superclass];
    }

    NSArray *result = [properties allObjects];
    objc_setAssociatedObject(objcClass, kCachedPropertiesKey, result, OBJC_ASSOCIATION_RETAIN);

    return result;
}

@end