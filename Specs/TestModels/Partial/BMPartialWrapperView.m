//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMPartialWrapperView.h"
#import "BMTestPartialView.h"

@implementation BMPartialWrapperView

@dynamic partialView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self addSubview:self.partialView];
    return self;
}

@end