//
//  BMInitializerModel.h
//  BloodMagic
//
//  Created by AlexDenisov on 3/19/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import <BloodMagic/Lazy.h>

@protocol BMInitializerSpecProtocol
    <NSCopying>

@end

@interface BMMember : NSObject
@property (nonatomic, strong) NSString *name;
@end

@interface BMInitializerModel : NSObject
    <BMLazy>

@property (nonatomic, strong) BMMember *member; // member.name should be_equal("member")
@property (nonatomic, strong) id<BMInitializerSpecProtocol> withProtocol; // should be_equal("base")
@property (nonatomic, strong) NSDictionary *customDictionary; // should be_equal( @{ "base" : @"value" } )

@end

@interface BMDerivedInitializerModel : BMInitializerModel

@property (nonatomic, strong) NSArray *justLazy; // should_not be_nil

@property (nonatomic, copy) NSString *customInitializer; // should be_equal("red green blue")

@end
