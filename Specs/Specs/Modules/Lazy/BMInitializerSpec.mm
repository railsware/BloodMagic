#import "SpecHelper.h"
#import "BMInitializer.h"
#import "BMInitializer+LazyInitializer.h"
#import "BMInitializerRegistry+LazyRegistry.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RDInitializerLazySpec)

describe(@"BMInitializer+Lazy", ^{
    __block BMInitializer *subject;

    beforeEach(^{
        subject = [BMInitializer lazyInitializer];
    });

    it(@"should not be nil", ^{
        subject should_not be_nil;
    });

    it(@"should have Lazy registry", ^{
        subject.registry should equal([BMInitializerRegistry lazyRegistry]);
    });

});

SPEC_END
