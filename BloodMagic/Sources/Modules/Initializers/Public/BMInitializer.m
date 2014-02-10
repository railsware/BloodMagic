//
// Created by Alex Denisov on 29.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMInitializer.h"
#import "BMInitializerRegistry.h"
#import "BMInitializer_Private.h"

@implementation BMInitializer
{
    NSSet *_protocols;
}

- (instancetype)init
{
    self = [super init];
    self.containerClass = [NSObject class];
    self.propertyClass = [NSObject class];

    return self;
}

- (void)registerInitializer
{
    [self.registry addInitializer:self];
}

- (NSArray *)protocols
{
    return [_protocols allObjects];
}

- (void)setProtocols:(NSArray *)protocols
{
    _protocols = [NSSet setWithArray:protocols];
}

- (NSSet *)protocolsSet
{
    return _protocols;
}

#pragma mark - Default initializer

static magic_initializer_t defaultInitializer = nil;
static BOOL hasDefaultInitializer = NO;

+ (void)setDefaultInitializer:(magic_initializer_t)initializer
{
    defaultInitializer = initializer;
    hasDefaultInitializer = YES;
}

+ (magic_initializer_t)defaultInitializer
{
    return defaultInitializer;
}

+ (BOOL)hasDefaultInitializer
{
    return hasDefaultInitializer;
}

+ (void)restoreDefaultInitializer
{
    defaultInitializer = nil;
    hasDefaultInitializer = NO;
}

@end
