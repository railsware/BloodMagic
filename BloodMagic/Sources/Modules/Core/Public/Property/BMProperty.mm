//
// Created by Alex Denisov on 16.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import <objc/runtime.h>

#import "BMClass.h"
#import "BMProperty_Private.h"
#import "BMInternalProperty.h"
#import "BMInternalPropertyFactory.h"

@implementation BMProperty
{
    Class _containerClass;
    Class _propertyClass;
    
    SEL _accessorSelector;
    SEL _mutatorSelector;
    
    NSString *_name;
    NSString *_accessor;
    NSString *_mutator;
    NSString *_containerClassName;
    
    BOOL _isDynamic;
    BOOL _isCopy;
    BOOL _isNonatomic;
    BOOL _isRetain;

    BMInternalProperty *_internalProperty;
    
    id _probableHook;
    id _hook;
}

- (instancetype)initWithProperty:(objc_property_t)property ofClass:(BMClass *)containerClass
{
    self = [super init];
    if (self) {
         _containerClassName = NSStringFromClass(containerClass.objcClass);
        _containerClass = containerClass.objcClass;
        _internalProperty = NULL;

        const char *name = property_getName(property);
        _name = @(name);
        [self parseProperty:property];
        [self setDefaultAccessor];
        [self setDefaultMutator];
        if (_internalProperty != NULL) {
            _internalProperty->setPropertyName([_name UTF8String]);
            _internalProperty->setAssociationPolicy([self associationPolicy]);
            _propertyClass = objc_getClass(_internalProperty->propertyClassName().c_str());
        }
    }
    return self;
}

- (BMInternalProperty *)internalProperty
{
    return _internalProperty;
}

- (void)dealloc
{
    if (_internalProperty != NULL) {
        delete _internalProperty;
    }
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

- (NSString *)propertyClassName
{
    return @(_internalProperty->propertyClassName().c_str());
}

- (NSString *)containerClassName
{
    return _containerClassName;
}

- (SEL)accessorSelector
{
    return _accessorSelector;
}

- (SEL)mutatorSelector
{
    return _mutatorSelector;
}

- (const char *)accessorTypes
{
    if (_internalProperty) {
        return _internalProperty->accessorTypes();
    }
    
    return NULL;
}

- (const char *)mutatorTypes
{
    if (_internalProperty) {
        return _internalProperty->mutatorTypes();
    }
    
    return NULL;
}

- (Class)containerClass
{
    return _containerClass;
}

- (Class)propertyClass
{
    return _propertyClass;
}

- (NSSet *)protocols
{
    return _internalProperty->protocols();
}

- (IMP)accessorImplementation
{
    if (_internalProperty == NULL) {
        return NULL;
    }

    return _internalProperty->accessorImplementation();
}

- (IMP)mutatorImplementation
{
    if (_internalProperty == NULL) {
        return NULL;
    }

    return _internalProperty->mutatorImplementation();
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

- (objc_AssociationPolicy)associationPolicy {
    objc_AssociationPolicy policy;
    if (_isNonatomic) {
        if (_isCopy) {
            policy = OBJC_ASSOCIATION_COPY_NONATOMIC;
        } else if (_isRetain) {
            policy = OBJC_ASSOCIATION_RETAIN_NONATOMIC;
        } else {
            policy = OBJC_ASSOCIATION_ASSIGN;
        }
    } else {
        if (_isCopy) {
            policy = OBJC_ASSOCIATION_COPY;
        } else if (_isRetain) {
            policy = OBJC_ASSOCIATION_RETAIN;
        } else {
            policy = OBJC_ASSOCIATION_ASSIGN;
        }
    }

    return policy;
}

#pragma mark - Property parsing

- (void)parseProperty:(objc_property_t)property
{
    uint attributesCount = 0;
    objc_property_attribute_t *attributes = property_copyAttributeList(property, &attributesCount);
    for (uint attributeIndex = 0; attributeIndex != attributesCount; ++attributeIndex) {
        objc_property_attribute_t attribute = attributes[attributeIndex];
        [self parsePropertyAttribute:attribute];
    }
    free(attributes);
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
        case 'T':{
            _internalProperty = [BMInternalPropertyFactory newInternalPropertyFromType:attribute.value];
            if (_internalProperty != NULL) {
                _internalProperty->setProperty(self);
            }
        } break;
        default: {
//            NSLog(@"Unused attribute: '%s' with value '%s'", attribute.name, attribute.value);
        }
    }
}

- (void)setAccessor:(const char *)accessor
{
    _accessor = @(accessor);
    _accessorSelector = sel_getUid(accessor);
}

- (void)setMutator:(const char *)mutator
{
    _mutator = @(mutator);
    _mutatorSelector = sel_getUid(mutator);
}

- (void)setDefaultAccessor
{
    if (_accessorSelector) {
        return;
    }
    _accessor = [_name copy];
    _accessorSelector = NSSelectorFromString(_accessor);
}

- (void)setDefaultMutator
{
    if (_mutatorSelector) {
        return;
    }
    NSString *capitalizedProperty = [_name stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                   withString:[[_name substringToIndex:1] capitalizedString]];
    _mutator = [NSString stringWithFormat:@"set%@:", capitalizedProperty];
    _mutatorSelector = NSSelectorFromString(_mutator);
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    return [self isEqualToProperty:object];
}

- (BOOL)isEqualToProperty:(BMProperty *)property
{
    // initial implementation, should be replaced with something more intelligent
    return [self.name isEqualToString:property.name];
}

#pragma mark - Hooks

- (id<BMHook>)hook
{
    if (_hook) {
        return _hook;
    }
    
    return _probableHook;
}

- (void)setHook:(id<BMHook>)hook
{
    _hook = hook;
}

- (void)setProbableHook:(id<BMHook>)hook
{
    _probableHook = hook;
}

@end

