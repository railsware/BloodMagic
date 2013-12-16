//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMLazy.h"

@class BMUser;
@class BMProject;
@protocol BMLazyTestProtocol;

@interface BMLazyModel : NSObject
    <BMLazy>

@property (nonatomic, copy) NSString *stringProperty;
@property (nonatomic, copy) NSString *someTitle;
@property (nonatomic, strong) BMUser *user;
@property (nonatomic, strong) BMProject *project;
@property (nonatomic, strong) id<BMLazyTestProtocol> propertyWithProtocol;

@end