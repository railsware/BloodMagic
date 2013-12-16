#import <objc/runtime.h>
#import "SpecHelper.h"
#import "BMProperty.h"
#import "BMFatModel.h"
#import "BMProperty_Private.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

typedef BMProperty * (^PropertyBlock)(const char *);

SPEC_BEGIN(BMPropertySpec)

context(@"instance", ^{
    PropertyBlock propertyWithName = ^BMProperty *(const char *propertyName){
        objc_property_t property_t = class_getProperty([BMFatModel class], propertyName);
        BMProperty *property = [[[BMProperty alloc] initWithProperty:property_t ofClass:Nil] autorelease];
        return property;
    };

    __block BMProperty *property = nil;

    context(@"should parse", ^{

        describe(@"nonatomic", ^{
            property = propertyWithName("nonatomicProperty");
            property.isNonatomic should be_truthy;
        });

        describe(@"atomic", ^{
            property = propertyWithName("atomicProperty");
            property.isNonatomic should_not be_truthy;
        });

        describe(@"copy", ^{
            property = propertyWithName("attrCopyProperty");
            property.isCopy should be_truthy;
            property.isRetain should_not be_truthy;
        });

        describe(@"dynamic", ^{
            property = propertyWithName("dynamicProperty");
            property.isDynamic should be_truthy;
        });

        describe(@"retain", ^{
            property = propertyWithName("retainProperty");
            property.isRetain should be_truthy;
            property.isCopy should_not be_truthy;
            property.isAssign should_not be_truthy;
        });

        describe(@"strong", ^{
            property = propertyWithName("strongProperty");
            property.isRetain should be_truthy;
            property.isCopy should_not be_truthy;
            property.isAssign should_not be_truthy;
        });

        describe(@"assign", ^{
            property = propertyWithName("assignProperty");
            property.isRetain should_not be_truthy;
            property.isCopy should_not be_truthy;
            property.isAssign should be_truthy;
        });

        describe(@"weak attributes", ^{
            property = propertyWithName("weakProperty");
            property.isRetain should_not be_truthy;
            property.isCopy should_not be_truthy;
            property.isAssign should be_truthy;
        });
        
        describe(@"default accessor", ^{
            property = propertyWithName("assignProperty");
            property.accessor should equal(@"assignProperty");
        });

        describe(@"default mutator", ^{
            property = propertyWithName("assignProperty");
            property.mutator should equal(@"setAssignProperty:");
        });

        describe(@"custom accessor", ^{
            property = propertyWithName("name");
            property.accessor should equal(@"firstName");
        });

        describe(@"custom mutator", ^{
            property = propertyWithName("name");
            property.mutator should equal(@"setFirstName:");
        });

        describe(@"unkwnown type (id)", ^{
            property = propertyWithName("unknownType");
            property.propertyClass should equal([NSObject class]);
        });

        describe(@"protocols", ^{

            it(@"nil by default", ^{
                property = propertyWithName("unknownType");
                property.protocols should be_nil;
            });

            it(@"not nil if protocol exists", ^{
                property = propertyWithName("propertyWithProtocols");
                property.protocols should_not be_nil;
            });

            it(@"collect all protocols if they're exist", ^{
                property = propertyWithName("propertyWithProtocols");
                property.protocols.count should_not equal(0);
                property.protocols should contain(@protocol(NSCoding));
            });

        });

    });

});

SPEC_END
