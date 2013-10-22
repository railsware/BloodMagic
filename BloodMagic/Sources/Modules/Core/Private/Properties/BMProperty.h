//
// Created by Alex Denisov on 16.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface BMProperty : NSObject

- (instancetype)initWithProperty:(objc_property_t)property ofClass:(Class)containerClass;

- (NSString *)name;
- (NSString *)accessor;
- (NSString *)mutator;
- (NSString *)propertyClassName;
- (NSString *)containerClassName;

- (NSArray *)protocols;

- (IMP)accessorImplementation;
- (IMP)mutatorImplementation;

- (BOOL)isDynamic;
- (BOOL)isCopy;
- (BOOL)isNonatomic;
- (BOOL)isRetain;
- (BOOL)isAssign;


@end