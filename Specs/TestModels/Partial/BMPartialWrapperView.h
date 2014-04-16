//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Partial.h"

@class BMTestPartialView;

@interface BMPartialWrapperView : UIView
    <BMPartial>

@property (nonatomic, strong) BMTestPartialView *partialView;

@end