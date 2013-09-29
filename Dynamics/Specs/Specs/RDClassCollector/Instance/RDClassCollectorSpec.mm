#import "SpecHelper.h"
#import "RDClassCollector.h"

#import "RDUser.h"
#import "RDEntityWithoutProtocols.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RDClassCollectorSpec)

context(@"instance", ^{

    __block RDClassCollector *subject;

    beforeEach(^{
        subject = [RDClassCollector new];
    });

    afterEach(^{
        [subject release];
    });

    describe(@"responds to", ^{

        it(@"collectForProtocol:", ^{
            [subject respondsToSelector:@selector(collectForProtocol:)] should be_truthy;
        });

    });

    describe(@"collect", ^{

        describe(@"only classes that conforms protocol", ^{
            __block Protocol *protocol = @protocol(RDTestProtocol);

            it(@"should pass", ^{
                [subject collectForProtocol:protocol] should contain([RDUser class]);
            });

            it(@"should pass", ^{
                [subject collectForProtocol:protocol] should_not contain([RDEntityWithoutProtocols class]);
            });

        });

    });

});

SPEC_END
