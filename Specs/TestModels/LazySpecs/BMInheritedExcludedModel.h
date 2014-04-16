//
//  BMInheritedExcludedModel.h
//  BloodMagic
//
//  Created by Eugene Solodovnykov on 09/11/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import "BMLazyModel.h"
#import "BMLazyExclude.h"

@interface BMInheritedExcludedModel : BMLazyModel <BMLazyExclude>

@property (nonatomic, strong) BMUser *admin;

@end
