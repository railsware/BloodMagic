#import "SpecHelper.h"
#import "RDProperty.h"
#import "RDFatModel.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

typedef RDProperty * (^PropertyBlock)(const char *);

SPEC_BEGIN(RDPropertySpec)

context(@"instance", ^{
    PropertyBlock propertyWithName = ^RDProperty *(const char *propertyName){
        objc_property_t property_t = class_getProperty([RDFatModel class], propertyName);
        RDProperty *property = [[[RDProperty alloc] initWithProperty:property_t ofClass:Nil] autorelease];
        return property;
    };

    __block RDProperty *property = nil;

    context(@"parse", ^{

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

    });

});

SPEC_END
