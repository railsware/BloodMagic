//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDDefinitions.h"

@class RDInitializerRegistry;

@interface RDInitializer : NSObject

@property (nonatomic, strong) RDInitializerRegistry *registry;
@property (nonatomic, strong) Class propertyClass;
@property (nonatomic, strong) Class containerClass;

@property (nonatomic, copy) dynamics_initializer_t initializer;

- (void)registerInitializer;

@end