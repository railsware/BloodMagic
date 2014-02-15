#import "SpecHelper.h"
#import "BMMultiple.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MultiplePropertiesSpec)

describe(@"MultipleProperties", ^{
    __block BMMultiple *model;

    beforeEach(^{
        model = [BMMultiple new];
    });
    
    it(@"should support Final", ^{
        model.final should be_nil;
        model.final = @"Clash";
        ^{
            model.final = @"and Crash";
        } should raise_exception.with_reason(@"Attempt to change final property");
    });
    
    it(@"should support Lazy", ^{
        model.lazy should_not be_nil;
        ^{
            model.lazy = @"Clash";
        } should_not raise_exception;
    });
    
});

SPEC_END
