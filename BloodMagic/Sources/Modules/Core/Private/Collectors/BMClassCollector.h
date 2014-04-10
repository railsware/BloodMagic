//
// Created by Alex Denisov on 12.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMInternalTypes.h"

@interface BMClassCollector : NSObject

+ (instancetype)collector;

- (class_list_t *)collectForProtocol:(Protocol *)protocol;

@end
