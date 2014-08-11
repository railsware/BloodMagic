#import "SpecHelper.h"

#import "Lazy.h"
#import "BMLazyModel.h"
#import "BMUser.h"
#import "BMProject.h"
#import "BMAnotherLazyModel.h"
#import "BMTestProtocolModel.h"
#import "BMBaseModel.h"
#import "BMDerivedModel.h"
#import "BMDerivedLazyModel.h"
#import "BMDerivedExtendedModel.h"
#import "BMInheritedModel.h"
#import "BMInheritedExcludedModel.h"
#import "BMInitializer_Private.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(LazySpec)

describe(@"LazySpec", ^{
    __block BMLazyModel *subject = nil;

    beforeEach(^{
        subject = [BMLazyModel new];
    });

    afterEach(^{
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

            it(@"custom objects storing", ^{
                subject.user should equal(subject.user);
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

        describe(@"subclasses", ^{

            it(@"should inherit behavior", ^{
                BMBaseModel *base = [BMBaseModel new];
                base.test should_not be_nil;

                BMDerivedModel *derived = [BMDerivedModel new];
                derived.test should_not be_nil;
            });

            it(@"should support lazy classes inherited from another lazy classes", ^{
                BMDerivedLazyModel *derivedLazy = [BMDerivedLazyModel new];
                derivedLazy.test should_not be_nil;
            });

            it(@"should support lazy classes with added properties inherited from another lazy classes", ^{
                BMDerivedExtendedModel *derivedExtended = [BMDerivedExtendedModel new];
                derivedExtended.test should_not be_nil;
                derivedExtended.user should_not be_nil;
            });

        });

    });

});

SPEC_END
