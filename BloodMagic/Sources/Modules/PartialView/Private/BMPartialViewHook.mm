//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMPartialViewHook.h"
#import "BMProperty.h"
#import "BMPropertyValueService.h"

@implementation BMPartialViewHook

+ (void)accessorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
    if (*value != nil) {
        return;
    }

    if (![property.containerClass conformsToProtocol:@protocol(BMPartialView)]) {
        return;
    }

    NSString *nibName = NSStringFromClass(property.propertyClass);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    *value = [[nib instantiateWithOwner:nil options:nil] lastObject];

    setValueForProperty(sender, property, *value);
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end