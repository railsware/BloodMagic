//
// Created by Alex Denisov on 15.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BMPropertyCollector : NSObject

+ (instancetype)collector;

- (NSArray *)collectForClass:(Class)klass withProtocol:(Protocol *)protocol;
- (NSArray *)collectForClass:(Class)klass withProtocol:(Protocol *)protocol excludingProtocol:(Protocol *)excludingProtocol;

@end