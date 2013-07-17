//
// Created by Alex Denisov on 16.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//


#import <objc/runtime.h>
#import "RDProperty.h"

@implementation RDProperty
{
    NSString *_name;
    NSString *_accessor;
    NSString *_mutator;

    BOOL _isDynamic;
    BOOL _isCopy;
    BOOL _isNonatomic;
    BOOL _isRetain;
}

- (instancetype)initWithProperty:(objc_property_t)property
{
    self = [super init];
    if (self) {
        const char *name = property_getName(property);
        _name = @(name);
        [self parseProperty:property];
        [self setDefaultAccessor];
        [self setDefaultMutator];
    }
    return self;
}

- (NSString *)name
{
    return _name;
}

- (NSString *)accessor
{
    return _accessor;
}

- (NSString *)mutator
{
    return _mutator;
}

- (BOOL)isDynamic
{
    return _isDynamic;
}

- (BOOL)isCopy
{
    return _isCopy;
}

- (BOOL)isNonatomic
{
    return _isNonatomic;
}

- (BOOL)isRetain
{
    return _isRetain;
}

- (BOOL)isAssign
{
    return !_isRetain && !_isCopy;
}


#pragma mark - Property parsing

- (void)parseProperty:(objc_property_t)property
{
    uint attributesCount = 0;
    objc_property_attribute_t *attributes = property_copyAttributeList(property, &attributesCount);
    for (int attributeIndex = 0; attributeIndex < attributesCount; attributeIndex++) {
        objc_property_attribute_t attribute = attributes[attributeIndex];
        [self parsePropertyAttribute:attribute];
    }
}

/*
* Here is an explanation
* http://developer.apple.com/library/ios/#DOCUMENTATION/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
* */
- (void)parsePropertyAttribute:(objc_property_attribute_t)attribute
{
    switch (attribute.name[0]) {
        case 'C': {
            _isCopy = YES;
        } break;
        case '&': {
            _isRetain = YES;
        } break;
        case 'N': {
            _isNonatomic = YES;
        } break;
        case 'G': {
            [self setAccessor:attribute.value];
        } break;
        case 'S': {
            [self setMutator:attribute.value];
        } break;
        case 'D': {
            _isDynamic = YES;
        } break;
        default: {
            NSLog(@"Unused attribute: '%s' with value '%s'", attribute.name, attribute.value);
        }
    }
}

- (void)setAccessor:(const char *)accessor
{
    _accessor = @(accessor);
}

- (void)setMutator:(const char *)mutator
{
    _mutator = @(mutator);
}

- (void)setDefaultAccessor
{
    if (_accessor) {
        return;
    }
    _accessor = [_name copy];
}

- (void)setDefaultMutator
{
    if (_mutator) {
        return;
    }
    NSString *capitalizedProperty = [_name stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                   withString:[[_name substringToIndex:1] capitalizedString]];
    _mutator = [NSString stringWithFormat:@"set%@:", capitalizedProperty];
}

@end