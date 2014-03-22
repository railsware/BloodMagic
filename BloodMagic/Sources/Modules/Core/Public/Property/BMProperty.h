//
// Created by Alex Denisov on 16.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

@interface BMProperty : NSObject

- (NSString *)name;
- (NSString *)accessor DEPRECATED_MSG_ATTRIBUTE("Use 'accessorSelector' instead");
- (NSString *)mutator DEPRECATED_MSG_ATTRIBUTE("Use 'mutatorSelector' instead");
- (NSString *)propertyClassName DEPRECATED_MSG_ATTRIBUTE("Use 'propertyClass' instead");
- (NSString *)containerClassName DEPRECATED_MSG_ATTRIBUTE("Use 'containerClass' instead");

- (SEL)accessorSelector;
- (SEL)mutatorSelector;

- (const char *)accessorTypes;
- (const char *)mutatorTypes;

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
