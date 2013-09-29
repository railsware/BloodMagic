#import "SpecHelper.h"

#import "RDLazyModel.h"
#import "RDUser.h"
#import "RDInitializerRegistry.h"
#import "RDInitializer.h"
#import "RDInitializerRegistry+LazyRegistry.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(LazySpec)

describe(@"LazySpec", ^{
    __block RDLazyModel *subject = nil;

    beforeEach(^{
        subject = [RDLazyModel new];
    });

    afterEach(^{
        [subject release];
    });

    context(@"default values", ^{

        context(@"direct access", ^{

            it(@"Foundation objects", ^{
                subject.stringProperty should_not be_nil;
            });

            it(@"custom objects", ^{
                subject.user should_not be_nil;
            });

        });

        context(@"KVC", ^{

            it(@"Foundation objects", ^{
                [subject valueForKey:@"stringProperty"] should_not be_nil;
            });

            it(@"custom objects", ^{
                [subject valueForKey:@"user"] should_not be_nil;
            });

        });

    });

    context(@"custom values", ^{

        beforeEach(^{
            RDInitializer *initializer = [[[RDInitializer alloc] initWithPropertyClass:[RDUser class]] autorelease];
            initializer.registry = [RDInitializerRegistry lazyRegistry];
            [initializer registerInitializer:^id(id sender) {
                RDUser *user = [[RDUser new] autorelease];
                user.name = @"Alex";
                user.lazyModel = sender;
                return user;
            }];
        });

        it(@"custom objects", ^{
            subject.user.name should equal(@"Alex");
            subject.user.lazyModel should equal(subject);
        });

    });

});

SPEC_END
