#import "BMInitializerRegistry+Injectable.h"
#import "BMInitializer+Injectable.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMInjectableInitializerSpec)

describe(@"BMInitializer+Injectable", ^{
    __block BMInitializer *subject;
    
    beforeEach(^{
        subject = [BMInitializer injectableInitializer];
    });
    
    it(@"should not be nil", ^{
        subject should_not be_nil;
    });
    
    it(@"should have Lazy registry", ^{
        subject.registry should equal([BMInitializerRegistry injectableRegistry]);
    });
});

SPEC_END
