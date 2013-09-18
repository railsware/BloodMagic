//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDDynamicsInjector.h"
#import "RDLazy.h"

static void _lazyInitializer() __attribute__((constructor))
{
    RDDynamicsInjector *injector = [RDDynamicsInjector new];
    [injector injectDynamicsInto:@protocol(RDLazy)];
}

