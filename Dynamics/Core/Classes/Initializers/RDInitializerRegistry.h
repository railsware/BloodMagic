//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDDefinitions.h"

@interface RDInitializerRegistry : NSObject

- (void)setInitializer:(dynamics_initializer_t)initializer forKey:(NSString *)key;
- (dynamics_initializer_t)initializerForKey:(NSString *)key;

@end