//
// Created by Alex Denisov on 21.10.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#include <string>
#include <regex>
#import <objc/runtime.h>
#include "BMPropertyTypeParser.h"

void BMPropertyTypeParser::parse(const char *type)
{
    // TODO: cleanup
    std::string propertyTypeName(type + 1); // skip @

    size_t leftBracket = propertyTypeName.find("<");
    if (leftBracket != std::string::npos) {
        size_t rightBracket = propertyTypeName.rfind(">") + 1;
        std::string protocols = propertyTypeName.substr(leftBracket, rightBracket - leftBracket);
        propertyTypeName = propertyTypeName.replace(leftBracket, propertyTypeName.length(), "");

        std::regex protocolsRegex("<.*?>");
        const std::sregex_token_iterator end;
        std::sregex_token_iterator start(protocols.cbegin(), protocols.cend(), protocolsRegex);

        NSMutableSet *protocolsSet = [NSMutableSet new];

        for (; start != end; start++) {
            std::string protocolName = *start;
            protocolName = protocolName.substr(1, protocolName.length() - 2);
            Protocol *protocol = objc_getProtocol(protocolName.c_str());
            
            assert(protocol); // undefined protocol
            
            [protocolsSet addObject:protocol];
        }
        _protocols = [NSSet setWithSet:protocolsSet];
    }

    propertyTypeName.erase(std::remove(propertyTypeName.begin(), propertyTypeName.end(), '"'), propertyTypeName.end());

    if (propertyTypeName.empty()) {
        propertyTypeName = "NSObject";
    }

    _propertyClassName = @(propertyTypeName.c_str());
}

NSSet *BMPropertyTypeParser::protocols() const
{
    return _protocols;
}

NSString *BMPropertyTypeParser::propertyClassName() const
{
    return _propertyClassName;
}
