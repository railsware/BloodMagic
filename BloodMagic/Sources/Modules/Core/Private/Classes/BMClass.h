//
//  BMClass.h
//  BloodMagic
//
//  Created by Eugene Solodovnykov on 30/10/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMClass : NSObject

+ (instancetype)classWithObjCClass:(Class)objcClass andProtocol:(Protocol *)protocol;

- (Class)objcClass;
- (NSSet *)protocols;
- (NSSet *)properties;
- (NSSet *)dynamicProperties;

@end
