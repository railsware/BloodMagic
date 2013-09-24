//
// Created by Alex Denisov on 17.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDDynamicsInjector.h"
#import "RDClassCollector.h"
#import "RDKVCInjector.h"
#import "RDDynamicPropertyInjector.h"

@implementation RDDynamicsInjector
{
    RDClassCollector *classCollector;
    RDKVCInjector *kvcInjector;
    RDDynamicPropertyInjector *propertyInjector;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        classCollector = [RDClassCollector new];
        kvcInjector = [RDKVCInjector new];
        propertyInjector = [RDDynamicPropertyInjector new];
    }

    return self;
}

- (void)injectDynamicsInto:(Protocol *)protocol
{
    NSArray *classes = [classCollector collectForProtocol:protocol];
    for (Class klass in classes) {
        [kvcInjector injectKVCHandlersIntoClass:klass];
        [propertyInjector injectDynamicHandlersIntoClass:klass];
    }
}

@end