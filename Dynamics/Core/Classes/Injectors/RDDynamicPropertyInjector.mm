//
// Created by Alex Denisov on 24.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDDynamicPropertyInjector.h"
#import "RDPropertyCollector.h"
#import "RDProperty.h"

@implementation RDDynamicPropertyInjector

- (instancetype)init
{
    self = [super init];
    self.propertyCollector = [RDPropertyCollector new];

    return self;
}

- (void)injectDynamicHandlersIntoClass:(Class)klass
{
    NSArray *properties = [self.propertyCollector collectForClass:klass];
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

@end