//
// Created by AlexDenisov on 8/7/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInjectable.h"

@interface BMInjectableBaseModel : NSObject
    <BMInjectable>

@property (nonatomic, copy) NSString *test;

@end
