#import "SpecHelper.h"
#import "RDPropertyCollector.h"
#import "RDClassCollector.h"
#import "RDTestProtocol.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

CDR_EXT
Tsuga<RDPropertyCollector>::runInstance(^{
    responds(^{
        to(@selector(collectForClass:));
    });

    context(@"collect", ^{

        describe(@"only dynamic properties", ^{
            __block Class klass = Nil;
            __block NSArray *properties = nil;

            Protocol *protocol = @protocol(RDTestProtocol);

            beforeEach(^{
                RDClassCollector *classCollector = [RDClassCollector new];
                klass = [classCollector collectForProtocol:protocol][0];
                properties = [subject() collectForClass:klass];
            });

            it(^{
                properties.count should equal(2);
            });

        });

    });
});

