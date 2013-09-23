//
// Created by Alex Denisov on 18.09.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "RDLazyHook.h"
#import "RDProperty.h"

@implementation RDLazyHook

+ (void)accessorHook:(id *)value withProperty:(const RDProperty *)property sender:(id)sender
{
    if (*value != nil) {
        return;
    }

    *value = [NSClassFromString(property.propertyClassName) new];
}

+ (void)mutatorHook:(id *)value withProperty:(const RDProperty *)property sender:(id)sender
{
}

@end