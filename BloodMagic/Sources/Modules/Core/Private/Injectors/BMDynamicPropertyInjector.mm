//
// Created by Alex Denisov on 24.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMDynamicPropertyInjector.h"
#import "BMPropertyCollector.h"
#import "BMProperty.h"

@implementation BMDynamicPropertyInjector

- (instancetype)init
{
    self = [super init];
    self.propertyCollector = [BMPropertyCollector new];

    return self;
}

- (void)injectDynamicHandlersIntoClass:(Class)klass
{
    NSArray *properties = [self.propertyCollector collectForClass:klass];
    for (BMProperty *property in properties) {
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