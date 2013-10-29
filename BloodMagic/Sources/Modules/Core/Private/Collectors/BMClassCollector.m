//
// Created by Alex Denisov on 12.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>
#import "BMClassCollector.h"

@implementation BMClassCollector

- (NSArray *)collectForProtocol:(Protocol *)protocol
{
    Class parentClass = NSClassFromString(@"NSObject");
    int numClasses = objc_getClassList(NULL, 0);
    Class classes[sizeof(Class) * numClasses];
    numClasses = objc_getClassList(classes, numClasses);
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++) {
        Class superClass = classes[i];
        do {
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != parentClass);

        if (superClass == nil) {
            continue;
        }

        Class klass = classes[i];
        if (![klass conformsToProtocol:protocol]) {
            continue;
        }
        [result addObject:klass];
    }
    return result;
}


@end