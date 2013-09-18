#import "SpecHelper.h"

#import "RDLazyModel.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(LazySpecSpec)

describe(@"LazySpec", ^{
    __block RDLazyModel *subject = nil;

    beforeEach(^{
        subject = [RDLazyModel new];
    });

    context(@"default values", ^{

        it(@"Foundation objects", ^{
            subject.stringProperty should_not be_nil;
        });

    });

});

SPEC_END
