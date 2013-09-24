//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDDynamicsInjector.h"
#import "RDLazy.h"

__attribute__((constructor)) static void _lazyInitializer()
{
    RDDynamicsInjector *injector = [RDDynamicsInjector new];
    [injector injectDynamicsInto:@protocol(RDLazy)];
}

