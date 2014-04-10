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
   
    if (*value != nil) {
        return;
    }

    NSString *nibName = NSStringFromClass(property.propertyClass);
    
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
   {
      UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
      *value = [[nib instantiateWithOwner:nil options:nil] lastObject];
   }
#elif TARGET_OS_MAC
   {
      NSNib *nib = [ [ NSNib alloc ] initWithNibNamed: nibName
                                               bundle: nil ];
      
      NSArray* topLevelObjects = nil;
      BOOL isNibInstantiated = [ nib instantiateWithOwner: nil
                                          topLevelObjects: &topLevelObjects ];
      NSParameterAssert( isNibInstantiated );
      
      *value = [ topLevelObjects lastObject ];
   }
#endif

    setValueForProperty(sender, property, *value);
}

+ (void)mutatorHook:(id *)value withProperty:(const BMProperty *)property sender:(id)sender
{
}

@end
