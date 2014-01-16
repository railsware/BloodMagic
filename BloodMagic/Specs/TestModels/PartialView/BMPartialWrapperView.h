//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartialView.h"

@class BMTestPartialView;

@interface BMPartialWrapperView : UIView
    <BMPartialView>

@property (nonatomic, strong) BMTestPartialView *partialView;

@end