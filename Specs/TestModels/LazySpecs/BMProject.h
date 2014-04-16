//
//  BMProject.h
//  BloodMagic
//
//  Created by AlexDenisov on 12/16/13.
//  Copyright (c) 2013 Railsware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMProject : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, weak) id lazyModel;

@end
