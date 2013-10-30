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

    describe(@"responds to", ^{

        it(@"collectorForClass:", ^{
            [subject respondsToSelector:@selector(collectForClass:withProtocol:)] should be_truthy;
        });

    });

    describe(@"collect", ^{
        __block Class klass = Nil;
        __block NSArray *properties = nil;

        Protocol *protocol = @protocol(BMTestProtocol);

        beforeEach(^{
            BMClassCollector *classCollector = [[BMClassCollector new] autorelease];
            klass = [classCollector collectForProtocol:protocol][0];
            properties = [subject collectForClass:klass withProtocol:protocol];
        });

        it(@"only dynamic properties", ^{
            properties.count should equal(2);
        });

    });

});

SPEC_END
