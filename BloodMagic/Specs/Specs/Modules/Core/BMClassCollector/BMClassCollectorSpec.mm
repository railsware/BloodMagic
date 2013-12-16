#import "SpecHelper.h"
#import "BMClassCollector.h"

#import "BMUser.h"
#import "BMEntityWithoutProtocols.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMClassCollectorSpec)

context(@"instance", ^{

    __block BMClassCollector *subject;

    beforeEach(^{
        subject = [BMClassCollector collector];
    });

    describe(@"responds to", ^{

        it(@"collectForProtocol:", ^{
            [subject respondsToSelector:@selector(collectForProtocol:)] should be_truthy;
        });

    });

    describe(@"collect", ^{

        describe(@"only classes that conforms protocol", ^{
            __block Protocol *protocol = @protocol(BMTestProtocol);

            it(@"should pass", ^{
                class_list_t *classes = [subject collectForProtocol:protocol];
                Class klass = [BMUser class];
                std::find(classes->begin(), classes->end(), klass) != classes->end() should be_truthy;
//                [subject collectForProtocol:protocol] should contain([BMUser class]);
            });

            it(@"should pass", ^{
                class_list_t *classes = [subject collectForProtocol:protocol];
                Class klass = [BMEntityWithoutProtocols class];
                std::find(classes->begin(), classes->end(), klass) != classes->end() should_not be_truthy;
//                [subject collectForProtocol:protocol] should_not contain([BMEntityWithoutProtocols class]);
            });

        });

    });

});

SPEC_END
