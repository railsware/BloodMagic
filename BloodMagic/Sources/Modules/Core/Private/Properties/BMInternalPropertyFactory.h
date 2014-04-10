//
// Created by Alex Denisov on 20.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

class BMInternalProperty;

@interface BMInternalPropertyFactory : NSObject

+ (BMInternalProperty *)newInternalPropertyFromType:(const char *)type;

@end
