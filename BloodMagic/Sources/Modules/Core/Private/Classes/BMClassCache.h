//
//  BMClassCache.h
//  BloodMagic
//
//  Created by AlexDenisov on 12/16/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMClass;

@interface BMClassCache : NSObject

+ (instancetype)cache;

- (BMClass *)internalClassForObjCClass:(Class)objcClass;
- (void)setInternalClass:(BMClass *)internalClass forObjCClass:(Class)objcClass;

@end
