//
// Created by AlexDenisov on 8/7/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInjectable.h"

@class BMUser;
@class BMProject;
@protocol BMInjectableTestProtocol;

@interface BMInjectableModel : NSObject
    <BMInjectable>

@property (nonatomic, copy) NSString *stringProperty;
@property (nonatomic, copy) NSString *someTitle;
@property (nonatomic, strong) BMUser *user;
@property (nonatomic, strong) BMProject *project;
@property (nonatomic, strong) id<BMInjectableTestProtocol> propertyWithProtocol;

@property (nonatomic, copy) NSString *nilObject;

@end
