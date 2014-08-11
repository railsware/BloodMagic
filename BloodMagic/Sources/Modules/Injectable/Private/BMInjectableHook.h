//
//  BMInjectableHook.h
//  BloodMagic
//
//  Created by AlexDenisov on 8/7/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInjectable.h"
#import "BMHook.h"

@interface BMInjectableHook : NSObject
    <BMHook,
    BMInjectable>

@end
