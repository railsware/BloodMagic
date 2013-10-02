#import "SpecHelper.h"
#import "RDInitializer.h"
#import "RDInitializer+LazyInitializer.h"
#import "RDInitializerRegistry.h"
#import "RDInitializerRegistry+LazyRegistry.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RDInitializerLazySpec)

describe(@"RDInitializer+Lazy", ^{
    __block RDInitializer *subject;

    beforeEach(^{
        subject = [RDInitializer lazyInitializer];
    });

    it(@"should not be nil", ^{
        subject should_not be_nil;
    });

    it(@"should have Lazy registry", ^{
        subject.registry should equal([RDInitializerRegistry lazyRegistry]);
    });

});

SPEC_END
