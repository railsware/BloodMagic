//
//  Private.h
//  Dynamics
//
//  Created by Alex Denisov on 20.07.13.
//  Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMProperty.h"
#import <objc/runtime.h>

class BMInternalProperty;
@class BMClass;
@protocol BMHook;

@interface BMProperty ()

- (instancetype)initWithProperty:(objc_property_t)property ofClass:(BMClass *)containerClass;
- (BMInternalProperty *)internalProperty;
- (id<BMHook>)hook;

- (void)setHook:(id<BMHook>)hook;
- (void)setProbableHook:(id<BMHook>)hook;

@end
