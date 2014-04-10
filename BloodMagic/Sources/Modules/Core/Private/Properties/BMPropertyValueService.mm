//
// Created by Alex Denisov on 27.10.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMPropertyValueService.h"
#import "BMProperty_Private.h"
#import "BMInternalProperty.h"

void setValueForProperty(id self, BMProperty const *property, id value)
{
    objc_setAssociatedObject(
            self,
            property.internalProperty->propertyName().c_str(),
            value,
            property.internalProperty->associationPolicy());
}

id getValueForProperty(id self, BMProperty const *property)
{
    return objc_getAssociatedObject(self, property.internalProperty->propertyName().c_str());
}
