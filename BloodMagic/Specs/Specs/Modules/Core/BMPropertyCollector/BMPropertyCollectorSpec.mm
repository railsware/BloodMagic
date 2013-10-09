#import "SpecHelper.h"
#import "BMPropertyCollector.h"
#import "BMClassCollector.h"
#import "BMTestProtocol.h"

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

    context(@"responds to", ^{

        it(@"collectorForClass:", ^{
            [subject respondsToSelector:@selector(collectForClass:)] should be_truthy;
        });

    });

    context(@"collect", ^{

        describe(@"only dynamic properties", ^{
            __block Class klass = Nil;
            __block NSArray *properties = nil;

            Protocol *protocol = @protocol(BMTestProtocol);

            beforeEach(^{
                BMClassCollector *classCollector = [[BMClassCollector new] autorelease];
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
