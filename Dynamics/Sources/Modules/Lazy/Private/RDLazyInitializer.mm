//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "Core.h"
#import "Lazy.h"

rd_module_initializer _lazyInitializer()
{
    RDDynamicsInjector *injector = [RDDynamicsInjector new];
    [injector injectDynamicsInto:@protocol(RDLazy)];
}

