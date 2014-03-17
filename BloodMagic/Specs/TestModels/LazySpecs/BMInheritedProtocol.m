//
// Created by AlexDenisov on 3/17/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInheritedProtocol.h"

lazy_initializer lazyInitialization()
{
    BMInitializer *initalizer = [BMInitializer lazyInitializer];
    initalizer.protocols = @[@protocol(NSCopying) ];
    initalizer.containerClass = [ChildClass class];
    initalizer.initializer = ^id(id sender) {
        return @"Hello";
    };
    [initalizer registerInitializer];
}

@implementation BaseClass

@lazy(lazyProperty)

@end

@implementation ChildClass

@end
