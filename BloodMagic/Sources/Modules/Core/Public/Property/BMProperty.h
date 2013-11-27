//
// Created by Alex Denisov on 16.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMProperty : NSObject

- (NSString *)name;
- (NSString *)accessor;
- (NSString *)mutator;
- (NSString *)propertyClassName;
- (NSString *)containerClassName;

- (NSSet *)protocols;

- (IMP)accessorImplementation;
- (IMP)mutatorImplementation;

- (BOOL)isDynamic;
- (BOOL)isCopy;
- (BOOL)isNonatomic;
- (BOOL)isRetain;
- (BOOL)isAssign;

- (BOOL)isEqualToProperty:(BMProperty *)property;

@end