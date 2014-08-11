//
//  BMHookedModel.m
//  BloodMagic
//
//  Created by AlexDenisov on 3/21/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMHookedModel.h"
#import "BMInitializer+Injectable.h"
#import "BMInjectableDefinitions.h"

injectable_initializer propertyWithHookInitializer()
{
    BMInitializer *initializer = [BMInitializer injectableInitializer];
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
