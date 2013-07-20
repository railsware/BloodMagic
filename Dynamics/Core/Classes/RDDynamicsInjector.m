//
// Created by Alex Denisov on 17.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDDynamicsInjector.h"
#import "RDClassCollector.h"
#import "RDPropertyCollector.h"
#import "RDProperty.h"

@implementation RDDynamicsInjector

- (void)injectDynamicsInto:(Protocol *)protocol
{
    RDClassCollector *classCollector = [RDClassCollector new];
    RDPropertyCollector *propertyCollector = [RDPropertyCollector new];

    NSArray *classes = [classCollector collectForProtocol:protocol];
    for (Class klass in classes) {
        NSArray *properties = [propertyCollector collectForClass:klass];
        for (RDProperty *property in properties) {
            class_addMethod(klass,
                    NSSelectorFromString(property.accessor),
                    property.accessorImplementation,
                    NULL);
            class_addMethod(klass,
                    NSSelectorFromString(property.mutator),
                    property.mutatorImplementation,
                    NULL);

        }
    }
}

@end