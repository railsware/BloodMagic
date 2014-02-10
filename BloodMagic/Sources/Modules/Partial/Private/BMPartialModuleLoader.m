//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMPartialModuleLoader.h"
#import "BMBloodMagicInjector.h"
#import "BMPartial.h"

@implementation BMPartialModuleLoader

+ (void)load
{
    @autoreleasepool {
        BMBloodMagicInjector *injector = [BMBloodMagicInjector new];
        [injector injectBloodMagicInto:@protocol(BMPartial)];
    }
}

@end
