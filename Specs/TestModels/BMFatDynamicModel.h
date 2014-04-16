//
// Created by Alex Denisov on 17.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMFatTestProtocol.h"

@interface BMFatDynamicModel : NSObject
    <BMFatTestProtocol>

@property (nonatomic, copy) NSString *nonatomicCopyObject;
@property (nonatomic, retain) NSString *nonatomicRetainObject;
@property (atomic, copy) NSString *atomicCopyObject;
@property (atomic, retain) NSString *atomicRetainObject;

@property (nonatomic, readwrite) char charProperty;
@property (nonatomic, readwrite) unsigned char unsignedCharProperty;
@property (nonatomic, readwrite) short shortProperty;
@property (nonatomic, readwrite) unsigned short unsignedShortProperty;
@property (nonatomic, readwrite) int intProperty;
@property (nonatomic, readwrite) unsigned int unsignedIntProperty;
@property (nonatomic, readwrite) long longProperty;
@property (nonatomic, readwrite) unsigned long unsignedLongProperty;
@property (nonatomic, readwrite) long long longLongProperty;
@property (nonatomic, readwrite) unsigned long long unsignedLongLongProperty;
@property (nonatomic, readwrite) float floatProperty;
@property (nonatomic, readwrite) double doubleProperty;
@property (nonatomic, readwrite) BOOL boolProperty;

@end