//
// Created by AlexDenisov on 4/10/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

@protocol BMPreference
    <NSObject>

@optional

// uses [NSUserDefaults standardUserDefaults] by default
- (NSUserDefaults *)userDefaults;
- (void)setUserDefaults:(NSUserDefaults *)userDefaults;

@end
