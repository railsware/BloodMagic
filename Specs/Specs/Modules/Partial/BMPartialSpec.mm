#import "SpecHelper.h"

#import "BMPartialWrapperView.h"
#import "BMTestPartialView.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMPartialSpec)

describe(@"BMPartialSpec", ^{
    __block BMPartialWrapperView *subject = nil;

    beforeEach(^{
        subject = [[BMPartialWrapperView alloc] initWithFrame:CGRectZero];
    });

    afterEach(^{
        subject = nil;
    });

    describe(@"partial view", ^{
        it(@"should be instantiated", ^{
            subject.partialView should_not be_nil;
        });
        it(@"should have superview", ^{
            subject.partialView.superview should equal(subject);
        });
        it(@"should have epected class", ^{
            subject.partialView should be_instance_of([BMTestPartialView class]);
        });
        it(@"should not create new instance", ^{
            subject.partialView should be_same_instance_as(subject.partialView);
        });
    });
});

SPEC_END
