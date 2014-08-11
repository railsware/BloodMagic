#import "SpecHelper.h"
#import "BMInitializerModel.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMInitializerFinderSpec)

describe(@"BMInitializerFinder", ^{
    __block BMInitializerModel *base;
    __block BMDerivedInitializerModel *derived;
    
    beforeEach(^{
        base = [BMInitializerModel new];
        derived = [BMDerivedInitializerModel new];
    });
    afterEach(^{
        base = nil;
        derived = nil;
    });
    
    describe(@"a lot of tests", ^{
        it(@"just should work", ^{
            id baseExpected = @"base";
            id derivedExpected = @"derived";
            base.withProtocol should equal(baseExpected);
            derived.withProtocol should equal(derivedExpected);
            
            base.customDictionary should equal( @{ @"base" : @"value" } );
            derived.customDictionary should equal( @{ @"base" : @"value" } );
            
            derived.justLazy should be_nil;
            derived.customInitializer should equal(@"red green blue");
            
            base.member.name should equal(@"member");
            derived.member.name should be_nil;
        });
    });
    
});

SPEC_END
