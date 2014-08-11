//
// Created by AlexDenisov on 8/7/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInjectable.h"
#import "BMInjectableDerivedModel.h"

@class BMUser;

@interface BMInjectableDerivedExtendedModel : BMInjectableDerivedModel
    <BMInjectable>

@property (nonatomic, strong) BMUser *user;

@end
