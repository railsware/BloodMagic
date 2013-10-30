//
// Created by Alex Denisov on 24.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMPropertyCollector;

@interface BMDynamicPropertyInjector : NSObject

@property (nonatomic, strong) BMPropertyCollector *propertyCollector;

- (void)injectDynamicHandlersIntoClass:(Class)klass withProtocol:(Protocol *)protocol;

@end