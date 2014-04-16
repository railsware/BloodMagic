//
//  BMHookedModel.m
//  BloodMagic
//
//  Created by AlexDenisov on 3/21/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMHookedModel.h"

lazy_initializer propertyWithHookInitializer()
{
    BMInitializer *initializer = [BMInitializer lazyInitializer];
    initializer.containerClass = [BMHookedModel class];
    initializer.propertyClass = [NSString class];
    initializer.initializer = ^id (id sender) {
        return @"hooked";
    };
    [initializer registerInitializer];
}

@implementation BMHookedModel

@dynamic lazyArray;
@dynamic propertyWithHook;

- (void)propertyWithHookInjected:(NSString *)propertyWithHook
{}

@end
