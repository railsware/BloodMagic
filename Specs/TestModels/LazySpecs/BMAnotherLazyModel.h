//
// Created by Alex Denisov on 02.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMInjectable.h"

@class BMUser;
@class BMProject;

@interface BMAnotherLazyModel : NSObject
    <BMInjectable>

@property (nonatomic, strong) BMUser *user;
@property (nonatomic, strong) BMProject *project;

@end