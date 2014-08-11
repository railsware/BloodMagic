//
//  BMHookedModel.h
//  BloodMagic
//
//  Created by AlexDenisov on 3/21/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import <BloodMagic/Injectable.h>

@interface BMHookedModel : NSObject
    <BMInjectable>

@property (nonatomic, strong) NSMutableArray *lazyArray;
@property (nonatomic, strong) NSString *propertyWithHook;

- (void)propertyWithHookInjected:(NSString *)propertyWithHook;

@end
