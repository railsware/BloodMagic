//
//  RDLazyModuleLoader.m
//  Dynamics
//
//  Created by Alex Denisov on 08.10.13.
//  Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDLazyModuleLoader.h"
#import "Core.h"
#import "Lazy.h"

@implementation RDLazyModuleLoader

+ (void)load
{
    RDDynamicsInjector *injector = [RDDynamicsInjector new];
    [injector injectDynamicsInto:@protocol(RDLazy)];
}

@end
