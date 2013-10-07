//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "RDInitializerRegistry.h"

@interface RDInitializerRegistry (LazyRegistry)

+ (instancetype)lazyRegistry;

@end