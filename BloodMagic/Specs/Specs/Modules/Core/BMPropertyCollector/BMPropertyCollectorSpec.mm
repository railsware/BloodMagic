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
        subject = [BMPropertyCollector new];
    });

    afterEach(^{
        [subject release];
    });

    describe(@"responds to", ^{

        it(@"collectorForClass:", ^{
            [subject respondsToSelector:@selector(collectForClass:withProtocol:)] should be_truthy;
        });

    });

    describe(@"collect", ^{
        __block NSArray *properties = nil;

        it(@"only dynamic properties", ^{
            properties = [subject collectForClass:[BMUser class] withProtocol:@protocol(BMTestProtocol)];
            properties.count should equal(2);
        });

        it(@"including base class' properties", ^{
            properties = [subject collectForClass:[BMDerivedExtendedModel class] withProtocol:@protocol(BMLazy)];
            properties.count should equal(2);
        });

    });

});

SPEC_END
