//
//  Private.h
//  Dynamics
//
//  Created by Alex Denisov on 20.07.13.
//  Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMProperty.h"
#import "BMInternalProperty.h"
#import <objc/runtime.h>

@interface BMProperty ()

- (instancetype)initWithProperty:(objc_property_t)property ofClass:(Class)containerClass;
- (BMInternalProperty *)internalProperty;

@end
