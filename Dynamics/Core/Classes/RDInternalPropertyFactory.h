//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

class RDInternalProperty;

@interface RDInternalPropertyFactory : NSObject

+ (RDInternalProperty *)newInternalPropertyFromType:(const char *)type;

@end