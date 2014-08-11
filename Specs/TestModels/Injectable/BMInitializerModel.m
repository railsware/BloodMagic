//
//  BMInitializerModel.m
//  BloodMagic
//
//  Created by AlexDenisov on 3/19/14.
//  Copyright (c) 2014 Railsware. All rights reserved.
//

#import <BloodMagic/Lazy.h>
#import "BMInitializer+Injectable.h"
#import "BMInjectableDefinitions.h"

#import "BMInitializerModel.h"

injectable_initializer registerInitializers()
{
    BMInitializer *initializer;
    
    initializer = [BMInitializer injectableInitializer];
    initializer.containerClass = [BMDerivedInitializerModel class];
    initializer.propertyClass = [NSString class];
    initializer.initializer = ^id(id sender) {
        return @"red green blue";
    };
    [initializer registerInitializer];
    
    initializer = [BMInitializer injectableInitializer];
    initializer.containerClass = [BMDerivedInitializerModel class];
    initializer.protocols = @[ @protocol(BMInitializerSpecProtocol) ];
    initializer.initializer = ^id(id sender) {
        return @"derived";
    };
    [initializer registerInitializer];
    
    initializer = [BMInitializer injectableInitializer];
    initializer.containerClass = [BMInitializerModel class];
    initializer.protocols = @[ @protocol(BMInitializerSpecProtocol) ];
    initializer.initializer = ^id(id sender) {
        return @"base";
    };
    [initializer registerInitializer];
    
    initializer = [BMInitializer injectableInitializer];
    initializer.propertyClass = [NSDictionary class];
    initializer.initializer = ^id(id sender) {
        return @{ @"base" : @"value" };
    };
    [initializer registerInitializer];
    
    initializer = [BMInitializer injectableInitializer];
    initializer.containerClass = [BMInitializerModel class];
    initializer.propertyClass = [BMMember class];
    initializer.initializer = ^id(id sender) {
        BMMember *member = [BMMember new];
        member.name = @"member";
        return member;
    };
    [initializer registerInitializer];
}

@implementation BMMember @end

@implementation BMInitializerModel

@dynamic customDictionary;
@dynamic withProtocol;
@dynamic member;

@end

@implementation BMDerivedInitializerModel

@dynamic justLazy;
@dynamic customInitializer;

@end
