//
// Created by Alex Denisov on 17.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDTestProtocol.h"

@interface RDFatDynamicModel : NSObject
    <RDTestProtocol>

@property (nonatomic, copy) NSString *nonatomicCopyObject;
@property (nonatomic, retain) NSString *nonatomicRetainObject;
@property (atomic, copy) NSString *atomicCopyObject;
@property (atomic, retain) NSString *atomicRetainObject;

@end