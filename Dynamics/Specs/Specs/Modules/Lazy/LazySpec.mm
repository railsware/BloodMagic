#import "SpecHelper.h"

#import "RDLazyModel.h"
#import "RDUser.h"
#import "RDInitializerRegistry.h"
#import "RDInitializer.h"
#import "RDInitializer+LazyInitializer.h"
#import "RDAnotherLazyModel.h"

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
        subject = nil;
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
            RDInitializer *initializer = [RDInitializer lazyInitializer];
            initializer.propertyClass = [RDUser class];
            initializer.containerClass = [RDLazyModel class];
            initializer.initializer = ^id(id sender){
                RDUser *user = [[RDUser new] autorelease];
                user.name = @"Alex";
                user.lazyModel = sender;
                return user;
            };
            [initializer registerInitializer];
        });

        it(@"should load custom objects", ^{
            subject.user.name should equal(@"Alex");
        });

        it(@"should have sender", ^{
            subject.user.lazyModel should equal(subject);
        });

        it(@"should consider container class", ^{
            RDAnotherLazyModel *anotherLazyModel = [[RDAnotherLazyModel new] autorelease];
            anotherLazyModel.user.name should be_nil;
        });

        it(@"should have NSObject container by default", ^{
            RDInitializer *initializer = [RDInitializer lazyInitializer];
            initializer.propertyClass = [RDUser class];
            initializer.initializer = ^id(id sender){
                RDUser *user = [[RDUser new] autorelease];
                user.name = @"Alex";
                return user;
            };
            [initializer registerInitializer];

            RDAnotherLazyModel *anotherLazyModel = [[RDAnotherLazyModel new] autorelease];
            anotherLazyModel.user.name should equal(@"Alex");
        });

    });

});

SPEC_END
