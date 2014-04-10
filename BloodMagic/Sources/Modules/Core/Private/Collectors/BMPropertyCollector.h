//
// Created by Alex Denisov on 15.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMInternalTypes.h"

@interface BMPropertyCollector : NSObject

+ (instancetype)collector;

- (property_list_t *)collectForClass:(Class)klass withProtocol:(Protocol *)protocol;
- (property_list_t *)collectForClass:(Class)klass withProtocol:(Protocol *)protocol excludingProtocol:(Protocol *)excludingProtocol;

@end
