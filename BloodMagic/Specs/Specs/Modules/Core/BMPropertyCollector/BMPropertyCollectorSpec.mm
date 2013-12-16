#import "SpecHelper.h"
#import "BMPropertyCollector.h"
#import "BMTestProtocol.h"
#import "BMDerivedExtendedModel.h"
#import "BMUser.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMPropertyCollectorSpec)

context(@"instance", ^{

    __block BMPropertyCollector *subject = nil;
    beforeEach(^{
        subject = [BMPropertyCollector collector];
    });

    describe(@"responds to", ^{

        it(@"collectorForClass:", ^{
            [subject respondsToSelector:@selector(collectForClass:withProtocol:excludingProtocol:)] should be_truthy;
        });

    });

    describe(@"collect", ^{
        __block property_list_t properties;

        it(@"only dynamic properties", ^{
            properties = [subject collectForClass:[BMUser class] withProtocol:@protocol(BMTestProtocol) excludingProtocol:nil];
            properties.size() should equal(2);
        });

        it(@"including base class' properties", ^{
            properties = [subject collectForClass:[BMDerivedExtendedModel class] withProtocol:@protocol(BMLazy) excludingProtocol:nil];
            properties.size() should equal(2);
        });

    });

});

SPEC_END
