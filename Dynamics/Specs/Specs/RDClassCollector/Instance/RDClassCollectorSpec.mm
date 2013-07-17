#import "SpecHelper.h"
#import "RDClassCollector.h"

#import "RDUser.h"
#import "RDEntityWithoutProtocols.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

CDR_EXT
Tsuga<RDClassCollector>::runInstance(^{
    responds(^{
        to(@selector(collectForProtocol:));
    });

    context(@"collect", ^{

        describe(@"only classes that conforms protocol", ^{
            __block RDClassCollector *collector = nil;
            __block Protocol *protocol = @protocol(RDTestProtocol);

            beforeEach(^{
                collector = subject();
            });

            it(^{
                [collector collectForProtocol:protocol] should contain([RDUser class]);
            });

            it(^{
                [collector collectForProtocol:protocol] should_not contain([RDEntityWithoutProtocols class]);
            });

        });

    });

});
