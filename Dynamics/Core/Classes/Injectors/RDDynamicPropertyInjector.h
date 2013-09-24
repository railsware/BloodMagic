//
// Created by Alex Denisov on 24.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RDPropertyCollector;

@interface RDDynamicPropertyInjector : NSObject

@property (nonatomic, strong) RDPropertyCollector *propertyCollector;

- (void)injectDynamicHandlersIntoClass:(Class)klass;

@end