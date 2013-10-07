#import "SpecHelper.h"
#import "RDPropertyCollector.h"
#import "RDClassCollector.h"
#import "RDTestProtocol.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RDPropertyCollectorSpec)

context(@"instance", ^{

    __block RDPropertyCollector *subject = nil;
    beforeEach(^{
        subject = [RDPropertyCollector new];
    });

    afterEach(^{
        [subject release];
    });

    context(@"responds to", ^{

        it(@"collectorForClass:", ^{
            [subject respondsToSelector:@selector(collectForClass:)] should be_truthy;
        });

    });

    context(@"collect", ^{

        describe(@"only dynamic properties", ^{
            __block Class klass = Nil;
            __block NSArray *properties = nil;

            Protocol *protocol = @protocol(RDTestProtocol);

            beforeEach(^{
                RDClassCollector *classCollector = [[RDClassCollector new] autorelease];
                klass = [classCollector collectForProtocol:protocol][0];
                properties = [subject collectForClass:klass];
            });

            it(@"should pass", ^{
                properties.count should equal(2);
            });

        });

    });

});

SPEC_END
