//
// Created by Alex Denisov on 24.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMDynamicPropertyInjector.h"
#import "BMPropertyCollector.h"
#import "BMProperty.h"

@implementation BMDynamicPropertyInjector

- (void)injectDynamicHandlersIntoClass:(Class)klass
                          withProtocol:(Protocol *)protocol
{
    return [self injectDynamicHandlersIntoClass:klass withProtocol:protocol excludingProtocol:nil];
}

- (void)injectDynamicHandlersIntoClass:(Class)klass
                          withProtocol:(Protocol *)protocol
                     excludingProtocol:(Protocol *)excludingProtocol
{
    BMPropertyCollector *collector = [BMPropertyCollector collector];
    
    property_list_t *properties = [collector collectForClass:klass
                                                withProtocol:protocol
                                           excludingProtocol:excludingProtocol];
    
    for (BMProperty *property : *properties) {
        class_addMethod(klass,
                        property.accessorSelector,
                        property.accessorImplementation,
                        property.accessorTypes);
        class_addMethod(klass,
                        property.mutatorSelector,
                        property.mutatorImplementation,
                        property.mutatorTypes);
    }
}

@end
