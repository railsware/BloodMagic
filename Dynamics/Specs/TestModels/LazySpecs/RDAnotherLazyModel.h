//
// Created by Alex Denisov on 02.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDLazy.h"

@class RDUser;

@interface RDAnotherLazyModel : NSObject
    <RDLazy>

@property (nonatomic, strong) RDUser *user;

@end