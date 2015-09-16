//
//  BMInitializerRegistry+Injectable.m
//  BloodMagic
//
//  Created by AlexDenisov on 8/7/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInitializerRegistry+Injectable.h"

@implementation BMInitializerRegistry (Injectable)

+ (instancetype)injectableRegistry
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
