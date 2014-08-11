//
//  BMInitializer+Injectable.m
//  BloodMagic
//
//  Created by AlexDenisov on 8/7/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInitializer+Injectable.h"
#import "BMInitializerRegistry+Injectable.h"

@implementation BMInitializer (Injectable)

+ (instancetype)injectableInitializer
{
    BMInitializer *initializer = [BMInitializer new];
    initializer.registry = [BMInitializerRegistry injectableRegistry];
    return initializer;
}

@end
