//
//  BMClass.h
//  BloodMagic
//
//  Created by Eugene Solodovnykov on 30/10/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMClass : NSObject

- (instancetype)initWithClass:(Class)objcClass;

- (NSSet *)protocols;
- (NSSet *)properties;

@end
