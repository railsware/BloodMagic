//
// Created by Alex Denisov on 15.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <objc/runtime.h>
#import "BMPropertyCollector.h"
#import "BMProperty.h"
#import "BMPrivateCoreDefinitions.h"

@implementation BMPropertyCollector

- (NSArray *)collectForClass:(Class)klass
{
    NSArray *cachedProperties = objc_getAssociatedObject(klass, kCachedPropertiesKey);
    if (cachedProperties != nil) {
        return cachedProperties;
    }
    objc_property_t *objcProperties;
    uint propertyCount = 0;
    objcProperties = class_copyPropertyList(klass, &propertyCount);
    NSMutableArray *properties = [NSMutableArray arrayWithCapacity:propertyCount];
    for (int propertyIndex = 0; propertyIndex < propertyCount; propertyIndex++) {
        objc_property_t objcProperty = objcProperties[propertyIndex];
        BMProperty *property = [[BMProperty alloc] initWithProperty:objcProperty ofClass:klass];
        if (property.isDynamic) {
            [properties addObject:property];
        }
    }
    free(objcProperties);

    Class superklass = [klass superclass];
    if (superklass != [NSObject class]) {
        NSArray *superklassProperties = [self collectForClass:superklass];
        [properties addObjectsFromArray:superklassProperties];
    }

    objc_setAssociatedObject(klass, kCachedPropertiesKey, [NSArray arrayWithArray:properties], OBJC_ASSOCIATION_RETAIN);
    return properties;
}

@end