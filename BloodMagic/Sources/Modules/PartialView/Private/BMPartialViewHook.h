//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMPartialView.h"
#import "BMHook.h"

@interface BMPartialViewHook : NSObject
    <BMHook,
    BMPartialView>

@end