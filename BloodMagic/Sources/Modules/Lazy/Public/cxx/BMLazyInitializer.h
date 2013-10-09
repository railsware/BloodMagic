//
// Created by Alex Denisov on 07.10.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#pragma once

#import "Initializers.h"
#import "BMInitializer+LazyInitializer.h"

template <class PropertyClass, class ContainerClass = NSObject>
struct BMLazyInitializer
{
    typedef PropertyClass *(^lazy_initializer_t)(ContainerClass *sender);

    static void registerInitializer(lazy_initializer_t initializer)
    {
        BMInitializer *lazyInitializer = [BMInitializer lazyInitializer];
        lazyInitializer.propertyClass = [PropertyClass class];
        lazyInitializer.containerClass = [ContainerClass class];
        lazyInitializer.initializer = initializer;
        [lazyInitializer registerInitializer];
    }
};
