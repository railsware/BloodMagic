#import "SpecHelper.h"
#import "BMInitializerModel.h"
#import "BMInjectableInitializerFinder.h"
#import "BMInitializerRegistry+Injectable.h"
#import "BMProperty.h"
#import "BMFatModel.h"
#import "BMProperty_Private.h"
#import "BMInitializer.h"

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
	
	describe(@"invalidate", ^{
		it(@"should clear cached initalizers", ^{
			objc_property_t property_t = class_getProperty([BMFatModel class], "nonatomicProperty");
			BMProperty *property = [[BMProperty alloc] initWithProperty:property_t ofClass:nil];
			BMInitializer *initializer = [BMInitializer new];
			initializer.propertyClass = [BMFatModel class];
			
			BMInitializerRegistry *registry = [BMInitializerRegistry injectableRegistry];
			[registry addInitializer:initializer];
			
			BMInjectableInitializerFinder *finder = [BMInjectableInitializerFinder finder];
			magic_initializer_t initializer_t = [finder initializerForProperty:property];

			initializer_t == nil should_not be_truthy;
			
			[finder invalidate];
			initializer_t = [finder cachedInitializerForProperty:property];
			
			initializer_t == nil should be_truthy;
		});
	});
});

SPEC_END
