#import "SpecHelper.h"
#import "BMHookedModel.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMLazyHooksSpec)

describe(@"BMLazyHooks", ^{
    __block BMHookedModel *sut;

    beforeEach(^{
        sut = [BMHookedModel new];
    });
    
    describe(@"hook", ^{
        it(@"fires if defined", ^{
            spy_on(sut);
            __unused NSString *s = sut.propertyWithHook;
            sut should have_received(@selector(propertyWithHookInjected:)).with(@"hooked");
        });
        it(@"doesn't fire if undefined", ^{
            spy_on(sut);
            __unused NSArray *a = sut.lazyArray;
            sut should_not have_received(@selector(lazyArrayInjected:));
        });
    });
});

SPEC_END
