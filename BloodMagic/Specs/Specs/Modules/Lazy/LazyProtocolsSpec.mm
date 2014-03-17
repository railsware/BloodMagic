#import "SpecHelper.h"
#import "BMInheritedProtocol.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(LazyProtocolsSpec)

describe(@"LazyProtocols", ^{

    __block ChildClass *sut;

    beforeEach(^{
        sut = [ChildClass new];
    });

    describe(@"property with protocols", ^{
        it(@"should work with inheritance", ^{
            sut.lazyProperty should equal(@"Hello");
        });
    });
});

SPEC_END
