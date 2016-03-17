//
// Created by AlexDenisov on 8/7/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BMInjectable
    <NSObject>

@optional
- (void)bm_propertyInjected:(NSString *)propertyName value:(id)value;

@end
