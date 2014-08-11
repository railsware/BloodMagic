//
// Created by AlexDenisov on 8/7/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInjectableModuleLoader.h"
#import "BMBloodMagicInjector.h"
#import "BMInjectable.h"
#import "BMInjectableExclude.h"

@implementation BMInjectableModuleLoader

+ (void)load
{
    @autoreleasepool {
        BMBloodMagicInjector *injector = [BMBloodMagicInjector new];
        [injector injectBloodMagicInto:@protocol(BMInjectable) excluding:@protocol(BMInjectableExclude)];
    }
}

@end
