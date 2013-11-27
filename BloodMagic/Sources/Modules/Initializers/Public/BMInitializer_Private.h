//
//  Private.h
//  BloodMagic
//
//  Created by Alex Denisov on 23.10.13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import "BMInitializer.h"

@interface BMInitializer ()

- (NSSet *)protocolsSet;

+ (magic_initializer_t)defaultInitializer;
+ (BOOL)hasDefaultInitializer;
+ (void)restoreDefaultInitializer;

@end
