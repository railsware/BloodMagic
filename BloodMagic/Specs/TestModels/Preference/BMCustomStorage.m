//
//  BMCustomStorage.m
//  BloodMagic
//
//  Created by AlexDenisov on 4/9/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMCustomStorage.h"

@implementation BMCustomStorage
{
    NSUserDefaults *_defaults;
}

@dynamic preference;

- (void)setUserDefaults:(NSUserDefaults *)userDefaults
{
    _defaults = userDefaults;
}

- (NSUserDefaults *)userDefaults
{
    return _defaults;
}

@end
