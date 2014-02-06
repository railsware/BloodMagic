//
//  BMFinalModuleLoader.m
//  BloodMagic
//
//  Created by AlexDenisov on 2/6/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMFinalModuleLoader.h"
#import "BMBloodMagicInjector.h"
#import "BMFinal.h"

@implementation BMFinalModuleLoader

+ (void)load
{
    @autoreleasepool {
        BMBloodMagicInjector *injector = [BMBloodMagicInjector new];
        [injector injectBloodMagicInto:@protocol(BMFinal)];
    }
}

@end
