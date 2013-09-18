//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol RDHook
    <NSObject>

+ (void)afterBoxingValue:(id *)value ofClass:(Class)klass;
+ (void)beforeBoxingValue:(id *)value ofClass:(Class)klass;

@end