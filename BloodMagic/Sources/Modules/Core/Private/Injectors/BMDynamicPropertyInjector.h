//
// Created by Alex Denisov on 24.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMDynamicPropertyInjector : NSObject

- (void)injectDynamicHandlersIntoClass:(Class)klass withProtocol:(Protocol *)protocol;
- (void)injectDynamicHandlersIntoClass:(Class)klass withProtocol:(Protocol *)protocol excludingProtocol:(Protocol *)excludingProtocol;

@end
