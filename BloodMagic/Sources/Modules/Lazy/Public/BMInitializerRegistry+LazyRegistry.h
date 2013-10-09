//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Initializers.h"

@interface BMInitializerRegistry (LazyRegistry)

+ (instancetype)lazyRegistry;

@end