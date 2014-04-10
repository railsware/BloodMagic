//
// Created by AlexDenisov on 4/10/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMPreferenceModuleLoader.h"
#import "BMPreference.h"
#import "BMBloodMagicInjector.h"

@implementation BMPreferenceModuleLoader

+ (void)load
{
    @autoreleasepool {
        BMBloodMagicInjector *injector = [BMBloodMagicInjector new];
        [injector injectBloodMagicInto:@protocol(BMPreference)];
    }
}

@end
