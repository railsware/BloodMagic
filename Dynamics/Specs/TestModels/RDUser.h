//
// Created by Alex Denisov on 12.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDTestProtocol.h"

@class RDLazyModel;

@interface RDUser : NSObject
    <RDTestProtocol>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, retain) NSNumber *age;

@property (nonatomic, weak) RDLazyModel *lazyModel;

@end