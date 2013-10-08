//
// Created by Alex Denisov on 07.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "Initializers.h"
#import "RDInitializer+LazyInitializer.h"

template <class PropertyClass, class ContainerClass = NSObject>
struct RDLazyInitializer
{
    typedef PropertyClass *(^lazy_initializer_t)(ContainerClass *sender);

    static void registerInitializer(lazy_initializer_t initializer)
    {
        RDInitializer *lazyInitializer = [RDInitializer lazyInitializer];
        lazyInitializer.propertyClass = [PropertyClass class];
        lazyInitializer.containerClass = [ContainerClass class];
        lazyInitializer.initializer = initializer;
        [lazyInitializer registerInitializer];
    }
};
