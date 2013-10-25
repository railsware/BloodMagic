//
// Created by Alex Denisov on 25.10.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMLazy.h"

@interface BMBaseModel : NSObject
    <BMLazy>

@property (nonatomic, copy) NSString *test;

@end