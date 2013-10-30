//
// Created by Alex Denisov on 15.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <objc/runtime.h>
#import "BMPropertyCollector.h"
#import "BMProperty.h"
#import "BMPrivateCoreDefinitions.h"
#import "BMClass.h"

@protocol BMLazy;

@implementation BMPropertyCollector

- (NSArray *)collectForClass:(Class)objcClass
{
    NSArray *cachedProperties = objc_getAssociatedObject(objcClass, kCachedPropertiesKey);
    if (cachedProperties != nil) {
        return cachedProperties;
    }

    BMClass *klass = [[BMClass alloc] initWithClass:objcClass];
    BOOL klassIsLazy = [[klass protocols] containsObject:@protocol(BMLazy)];

    NSMutableArray *properties = [NSMutableArray array];
    if (klassIsLazy) {
        NSSet *klassProperties = [klass properties];
        for (BMProperty *property in klassProperties) {
            if (property.isDynamic) {
                [properties addObject:property];
            }
        }
    }

    Class superklass = [objcClass superclass];
    if ([superklass conformsToProtocol:@protocol(BMLazy)]) {
        NSArray *superklassProperties = [self collectForClass:superklass];
        [properties addObjectsFromArray:superklassProperties];
    }

    objc_setAssociatedObject(objcClass, kCachedPropertiesKey, [NSArray arrayWithArray:properties], OBJC_ASSOCIATION_RETAIN);
    return properties;
}

@end