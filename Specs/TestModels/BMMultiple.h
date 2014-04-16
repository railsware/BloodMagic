//
//  BMMultiple.h
//  BloodMagic
//
//  Created by AlexDenisov on 2/15/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "Lazy.h"
#import "Final.h"

@interface BMMultiple : NSObject
    <BMLazy,
    BMFinal>

@property (nonatomic, strong) NSString *lazy;
@property (nonatomic, strong) NSString *final;

@end
