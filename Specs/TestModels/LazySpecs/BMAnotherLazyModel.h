//
// Created by Alex Denisov on 02.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMLazy.h"

@class BMUser;
@class BMProject;

@interface BMAnotherLazyModel : NSObject
    <BMLazy>

@property (nonatomic, strong) BMUser *user;
@property (nonatomic, strong) BMProject *project;

@end