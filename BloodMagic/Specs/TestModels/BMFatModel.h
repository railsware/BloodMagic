//
// Created by Alex Denisov on 16.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMFatModel : NSObject

@property (nonatomic, copy) NSString *nonatomicProperty;
@property (atomic, copy) NSString *atomicProperty;
@property (nonatomic, copy) NSString *attrCopyProperty;
@property (nonatomic, retain) NSString *retainProperty;
@property (nonatomic, strong) NSString *strongProperty;
@property (nonatomic, assign) NSString *assignProperty;
@property (nonatomic, copy) NSString *dynamicProperty;
@property (nonatomic, weak) NSMutableArray *weakProperty;

@property (nonatomic, copy, getter = firstName, setter = setFirstName:) NSString *name;

@property (nonatomic, strong) id unknownType;

@end