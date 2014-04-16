//
//  BMFinalModel.h
//  BloodMagic
//
//  Created by AlexDenisov on 2/5/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMFinal.h"

@interface BMFinalModel : NSObject
    <BMFinal>

@property (nonatomic, readonly, copy) NSString *finalProperty;

@end
