//
//  Created by Alex Denisov on 08.10.13.
//  Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMLazyModuleLoader.h"
#import "Core.h"
#import "Lazy.h"

@implementation BMLazyModuleLoader

+ (void)load
{
    @autoreleasepool {
        BMBloodMagicInjector *injector = [BMBloodMagicInjector new];
        [injector injectBloodMagicInto:@protocol(BMLazy) excluding:@protocol(BMLazyExclude)];
    }
}

@end
