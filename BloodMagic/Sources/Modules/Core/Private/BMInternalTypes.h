//
// Created by AlexDenisov on 12/11/13.
// Copyright (c) 2013 Railsware. All rights reserved.
//

#include <list>
#include <map>

typedef std::list<Class> class_list_t;
typedef std::list<id> property_list_t;

typedef std::map<NSUInteger, class_list_t *> class_list_map_t;
typedef std::map<NSUInteger, property_list_t *> property_list_map_t;
