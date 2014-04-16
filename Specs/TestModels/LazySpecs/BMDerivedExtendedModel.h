//
//  BMDerivedExtendedModel.h
//  BloodMagic
//
//  Created by Eugene Solodovnykov on 28/10/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import "BMBaseModel.h"

@class BMUser;

@interface BMDerivedExtendedModel : BMBaseModel
    <BMLazy>

@property (nonatomic, strong) BMUser *user;

@end
