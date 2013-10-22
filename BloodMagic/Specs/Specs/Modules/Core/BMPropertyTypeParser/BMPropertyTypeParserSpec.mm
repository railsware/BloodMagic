#import "SpecHelper.h"
#import "BMPropertyTypeParser.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMPropertyTypeParserSpec)

describe(@"BMPropertyTypeParser", ^{
    __block BMPropertyTypeParser parser;

    describe(@"parse", ^{

        it(@"real class", ^{
            parser.parse("@\"NSString\"");
            parser.propertyClassName() should equal(@"NSString");
        });

        it(@"id", ^{
            parser.parse("@");
            parser.propertyClassName() should equal(@"NSObject");
        });

        it(@"real class with one protocol", ^{
            parser.parse("@\"NSString<NSCopying>\"");
            parser.propertyClassName() should equal(@"NSString");
            parser.protocols().count should equal(1);
            parser.protocols() should contain(@"NSCopying");
        });

        it(@"id with one protocol", ^{
            parser.parse("@\"<NSCopying>\"");
            parser.propertyClassName() should equal(@"NSObject");
            parser.protocols().count should equal(1);
            parser.protocols() should contain(@"NSCopying");
        });

        it(@"real class with few protocols", ^{
            parser.parse("@\"NSString<NSCopying><NSCoding>\"");
            parser.propertyClassName() should equal(@"NSString");
            parser.protocols().count should equal(2);
            parser.protocols() should contain(@"NSCopying");
            parser.protocols() should contain(@"NSCoding");
        });

        it(@"id with few protocols", ^{
            parser.parse("@\"<NSCopying><NSCoding>\"");
            parser.propertyClassName() should equal(@"NSObject");
            parser.protocols().count should equal(2);
            parser.protocols() should contain(@"NSCopying");
            parser.protocols() should contain(@"NSCoding");
        });

    });

});

SPEC_END
