//
// Created by AlexDenisov on 3/17/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//


#import "Lazy.h"

@interface BaseClass : NSObject
    <BMLazy>

@property (nonatomic, strong) id<NSCopying> lazyProperty;

@end

@interface ChildClass : BaseClass

@end


