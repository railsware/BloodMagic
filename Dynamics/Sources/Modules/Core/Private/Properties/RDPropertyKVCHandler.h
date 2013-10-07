//
// Created by Alex Denisov on 23.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

@interface RDPropertyKVCHandler : NSObject

- (void)setDynamicsValue:(id)value forUndefinedKey:(NSString *)key;
- (id)dynamicsValueForUndefinedKey:(NSString *)key;

@end
