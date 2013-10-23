//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMPublicCoreDefnitions.h"

@class BMInitializerRegistry;

@interface BMInitializer : NSObject

@property (nonatomic, strong) BMInitializerRegistry *registry;
@property (nonatomic, strong) Class propertyClass;
@property (nonatomic, strong) Class containerClass;
@property (nonatomic, strong) NSArray *protocols;

@property (nonatomic, copy) magic_initializer_t initializer;

- (void)registerInitializer;

@end