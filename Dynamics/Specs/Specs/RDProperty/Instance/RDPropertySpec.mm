#import "SpecHelper.h"
#import "RDProperty.h"
#import "RDFatModel.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

objc_property_t propertyWithName(const char *name) {
    return class_getProperty([RDFatModel class], name);
}

CDR_EXT
Tsuga<RDProperty>::runInstance(^{
    __block RDProperty *property = nil;

    context(@"parse", ^{

        describe(@"nonatomic", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("nonatomicProperty")];
            property.isNonatomic should be_truthy;
        });

        describe(@"atomic", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("atomicProperty")];
            property.isNonatomic should_not be_truthy;
        });

        describe(@"copy", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("attrCopyProperty")];
            property.isCopy should be_truthy;
            property.isRetain should_not be_truthy;
        });

        describe(@"dynamic", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("dynamicProperty")];
            property.isDynamic should be_truthy;
        });

        describe(@"retain", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("retainProperty")];
            property.isRetain should be_truthy;
            property.isCopy should_not be_truthy;
            property.isAssign should_not be_truthy;
        });

        describe(@"strong", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("strongProperty")];
            property.isRetain should be_truthy;
            property.isCopy should_not be_truthy;
            property.isAssign should_not be_truthy;
        });

        describe(@"assign", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("assignProperty")];
            property.isRetain should_not be_truthy;
            property.isCopy should_not be_truthy;
            property.isAssign should be_truthy;
        });

        describe(@"default accessor", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("assignProperty")];
            property.accessor should equal(@"assignProperty");
        });

        describe(@"default mutator", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("assignProperty")];
            property.mutator should equal(@"setAssignProperty:");
        });

        describe(@"custom accessor", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("name")];
            property.accessor should equal(@"firstName");
        });

        describe(@"custom mutator", ^{
            property = [[RDProperty alloc] initWithProperty:propertyWithName("name")];
            property.mutator should equal(@"setFirstName:");
        });

    });

});

