//
// Created by Alex Denisov on 27.10.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMProperty;

#ifdef __c_plus_plus
extern "C" {
#endif

void setValueForProperty(id self, BMProperty const *property, id value);
id getValueForProperty(id self, BMProperty const *property);

#ifdef __c_plus_plus
}
#endif
