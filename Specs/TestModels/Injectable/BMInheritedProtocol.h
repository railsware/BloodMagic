//
// Created by AlexDenisov on 3/17/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMinjectable.h"

@interface BaseClass : NSObject
    <BMInjectable>

@property (nonatomic, strong) id<NSCopying> lazyProperty;

@end

@interface ChildClass : BaseClass

@end


