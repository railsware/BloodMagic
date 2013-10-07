//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDDefinitions.h"

@class RDInitializer;
@class RDProperty;

@interface RDInitializerRegistry : NSObject

- (void)addInitializer:(RDInitializer *)initializer;
- (RDInitializer *)initializerForProperty:(const RDProperty *)property;

@end