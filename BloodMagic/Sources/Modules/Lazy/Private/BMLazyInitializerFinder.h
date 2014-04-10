//
// Created by Alex Denisov on 05.11.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMPublicCoreDefnitions.h"

@class BMProperty;

@interface BMLazyInitializerFinder : NSObject

+ (instancetype)finder;

- (magic_initializer_t)initializerForProperty:(const BMProperty *)property;

@end
