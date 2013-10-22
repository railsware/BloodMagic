//
//  Created by Alex Denisov on 08.10.13.
//  Copyright (c) 2013 railsware. All rights reserved.
//

#import "Core.h"
#import "Lazy.h"

__attribute__((constructor)) static void bmLazyModuleLoader()
{
    BMBloodMagicInjector *injector = [BMBloodMagicInjector new];
    [injector injectBloodMagicInto:@protocol(BMLazy)];
}

