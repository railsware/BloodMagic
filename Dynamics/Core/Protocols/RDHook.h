//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RDProperty;

@protocol RDHook
    <NSObject>

@optional

+ (void)mutatorHook:(id *)value withProperty:(const RDProperty *)property sender:(id)sender;
+ (void)accessorHook:(id *)value withProperty:(const RDProperty *)property sender:(id)sender;

@end