//
// Created by AlexDenisov on 1/16/14.
// Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMPartialHook.h"
#import "BMProperty.h"
#import "BMPropertyValueService.h"



@implementation BMPartialHook

+ (void)accessorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
   NSParameterAssert( NULL != value );
//   if ( NULL == value )
//   {
//      return;
//   }
   
    if (*value != nil) {
        return;
    }

    if (![property.containerClass conformsToProtocol:@protocol(BMPartial)]) {
        return;
    }

    NSString *nibName = NSStringFromClass(property.propertyClass);
   
#if TARGET_OS_MAC
   NSNib *nib = [ [ NSNib alloc ] initWithNibNamed: nibName
                                            bundle: nil ];
   
   NSArray* topLevelObjects = nil;
   BOOL isNibInstantiated = [ nib instantiateWithOwner: nil
                                       topLevelObjects: &topLevelObjects ];
   NSParameterAssert( isNibInstantiated );
//   if ( !isNibInstantiated )
//   {
//      return;
//   }
   
   *value = [ topLevelObjects lastObject ];
#else
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
     *value = [[nib instantiateWithOwner:nil options:nil] lastObject];
#endif


    setValueForProperty(sender, property, *value);
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end