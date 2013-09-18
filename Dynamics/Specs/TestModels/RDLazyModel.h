//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDLazy.h"

@interface RDLazyModel : NSObject
    <RDLazy>

@property (nonatomic, copy) NSString *stringProperty;

@end