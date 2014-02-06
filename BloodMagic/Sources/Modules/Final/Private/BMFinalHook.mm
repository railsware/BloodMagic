//
//  BMFinalHook.m
//  BloodMagic
//
//  Created by AlexDenisov on 2/6/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMFinalHook.h"
#import "BMProperty.h"
#import "BMPropertyValueService.h"

@implementation BMFinalHook

+ (void)accessorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
    if (![property.containerClass conformsToProtocol:@protocol(BMFinal)]) {
        return;
    }
    
    id currentValue = getValueForProperty(sender, property);
    if (currentValue) {
        [[NSException exceptionWithName:NSInternalInconsistencyException
                                reason:@"Attempt to change final property"
                               userInfo:@{
                                          @"sender" : sender,
                                          @"value" : (*value) ?: @"nil",
                                          @"property" : property.name
                                          }] raise];
    }
    setValueForProperty(sender, property, *value);
}

@end
