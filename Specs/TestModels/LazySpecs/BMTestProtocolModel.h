//
// Created by Alex Denisov on 22.10.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMLazyTestProtocol.h"
#import "BMInjectableTestProtocol.h"

@interface BMTestProtocolModel : NSObject
    <BMLazyTestProtocol,
    BMInjectableTestProtocol>

@end