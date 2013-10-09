//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMInitializer;
@class BMProperty;

@interface BMInitializerRegistry : NSObject

- (void)addInitializer:(BMInitializer *)initializer;
- (BMInitializer *)initializerForProperty:(const BMProperty *)property;

@end