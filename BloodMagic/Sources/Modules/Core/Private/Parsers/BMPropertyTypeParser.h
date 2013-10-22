//
// Created by Alex Denisov on 21.10.13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#pragma once

class BMPropertyTypeParser
{
private:
    NSSet *_protocols;
    NSString *_propertyClassName;

public:
    void parse(const char *type);
    NSSet *protocols() const;
    NSString *propertyClassName() const;
};


