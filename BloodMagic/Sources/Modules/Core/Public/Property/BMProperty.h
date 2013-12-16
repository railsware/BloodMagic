//
// Created by Alex Denisov on 16.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMProperty : NSObject

- (NSString *)name;
- (NSString *)accessor DEPRECATED_ATTRIBUTE;
- (NSString *)mutator DEPRECATED_ATTRIBUTE;
- (NSString *)propertyClassName DEPRECATED_ATTRIBUTE;
- (NSString *)containerClassName DEPRECATED_ATTRIBUTE;

- (SEL)accessorSelector;
- (SEL)mutatorSelector;

- (Class)propertyClass;
- (Class)containerClass;

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