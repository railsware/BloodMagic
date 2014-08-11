//
//  BMInitializerModel.h
//  BloodMagic
//
//  Created by AlexDenisov on 3/19/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import "BMInjectable.h"

@protocol BMInitializerSpecProtocol
    <NSCopying>

@end

@interface BMMember : NSObject
@property (nonatomic, strong) NSString *name;
@end

@interface BMInitializerModel : NSObject
    <BMInjectable>

@property (nonatomic, strong) BMMember *member; // member.name should be_equal("member")
@property (nonatomic, strong) id<BMInitializerSpecProtocol> withProtocol; // should be_equal("base")
@property (nonatomic, strong) NSDictionary *customDictionary; // should be_equal( @{ "base" : @"value" } )

@end

@interface BMDerivedInitializerModel : BMInitializerModel

@property (nonatomic, strong) NSArray *justLazy; // should be_nil

@property (nonatomic, copy) NSString *customInitializer; // should be_equal("red green blue")

@end
