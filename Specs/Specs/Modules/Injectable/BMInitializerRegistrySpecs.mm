#import "SpecHelper.h"
#import "BMInitializerRegistry.h"
#import "BMInitializer.h"
#import "BMInjectableInitializerFinder.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMInitializerRegistrySpec)

describe(@"BMInitializerRegistry", ^{
	__block BMInitializerRegistry *registry;
	
	beforeEach(^{
		registry = [BMInitializerRegistry new];
	});
	afterEach(^{
		registry = nil;
	});
	
	describe(@"adding and removing", ^{
		it(@"should start empty", ^{
			NSArray* initializers = [registry valueForKey:@"initializers"];
			initializers.count should equal(0);
		});
		it(@"should allow an initializer to be added", ^{
			[registry addInitializer:[BMInitializer new]];
			NSArray* initializers = [registry valueForKey:@"initializers"];
			initializers.count should equal(1);
		});
		it(@"should allow an initializer to be removed", ^{
			BMInitializer* initializer = [BMInitializer new];
			[registry addInitializer:initializer];
			NSArray* initializers = [registry valueForKey:@"initializers"];
			[registry removeInitializer:initializer];
			initializers.count should equal(0);
		});
		it(@"should allow all initializers to be removed", ^{
			[registry addInitializer:[BMInitializer new]];
			[registry addInitializer:[BMInitializer new]];
			[registry removeAllInitializers];
			NSArray* initializers = [registry valueForKey:@"initializers"];
			initializers.count should equal(0);
		});
	});
	
	describe(@"cache invalidation", ^{
		it(@"should invalidate the cache when removing an initializer", ^{
			BMInjectableInitializerFinder* finder = [BMInjectableInitializerFinder finder];
			spy_on(finder);

			BMInitializer* initializer = [BMInitializer new];
			[registry addInitializer:initializer];
			[registry removeInitializer:initializer];
			
			finder should have_received(NSSelectorFromString(@"invalidate"));
		});
		it(@"should invalidate the cache when removing all initializers", ^{
			BMInjectableInitializerFinder* finder = [BMInjectableInitializerFinder finder];
			spy_on(finder);
			
			[registry addInitializer:[BMInitializer new]];
			[registry removeAllInitializers];
			
			finder should have_received(NSSelectorFromString(@"invalidate"));
		});
	});
	
});

SPEC_END
