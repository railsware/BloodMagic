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

@end