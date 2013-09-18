//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDLazyHook.h"

@implementation RDLazyHook

+ (void)afterBoxingValue:(id *)value ofClass:(Class)klass
{
}

+ (void)beforeBoxingValue:(id *)value ofClass:(Class)klass
{
    if (*value == nil) {
        NSLog(@"%@ %@", *value, NSStringFromClass(klass));
        *value = [klass new];
        NSLog(@"%@ %@", *value, NSStringFromClass(klass));
    }
}

@end