//
// Created by Alex Denisov on 24.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMKVCInjector : NSObject

- (void)injectKVCHandlersIntoClass:(Class)klass;

@end