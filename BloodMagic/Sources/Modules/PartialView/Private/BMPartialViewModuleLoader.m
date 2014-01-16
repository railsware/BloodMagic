//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMPartialViewModuleLoader.h"
#import "BMBloodMagicInjector.h"
#import "BMPartialView.h"

@implementation BMPartialViewModuleLoader

+ (void)load
{
    @autoreleasepool {
        BMBloodMagicInjector *injector = [BMBloodMagicInjector new];
        [injector injectBloodMagicInto:@protocol(BMPartialView)];
    }
}

@end