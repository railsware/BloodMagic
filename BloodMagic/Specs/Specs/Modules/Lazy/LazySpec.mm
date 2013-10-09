#import "SpecHelper.h"

#import "Lazy.h"
#import "Lazy_cxx.h"
#import "BMLazyModel.h"
#import "BMUser.h"
#import "BMAnotherLazyModel.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(LazySpec)

describe(@"LazySpec", ^{
    __block BMLazyModel *subject = nil;

    beforeEach(^{
        subject = [BMLazyModel new];
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
            BMInitializer *initializer = [BMInitializer lazyInitializer];
            initializer.propertyClass = [BMUser class];
            initializer.containerClass = [BMLazyModel class];
            initializer.initializer = ^id(id sender){
                BMUser *user = [[BMUser new] autorelease];
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
            BMAnotherLazyModel *anotherLazyModel = [[BMAnotherLazyModel new] autorelease];
            anotherLazyModel.user.name should be_nil;
        });

        it(@"should have NSObject container by default", ^{
            BMLazyInitializer<BMUser>::registerInitializer(^BMUser *(NSObject *sender) {
                BMUser *user = [[BMUser new] autorelease];
                user.name = @"Alex";
                return user;
            });

            BMAnotherLazyModel *anotherLazyModel = [[BMAnotherLazyModel new] autorelease];
            anotherLazyModel.user.name should equal(@"Alex");
        });

    });

});

SPEC_END
