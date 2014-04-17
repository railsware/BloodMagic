#import "SpecHelper.h"

#import "Lazy.h"
#import "Lazy_cxx.h"
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

    context(@"custom values", ^{

        beforeEach(^{
            BMInitializer *initializer = [BMInitializer lazyInitializer];
            initializer.propertyClass = [BMProject class];
            initializer.containerClass = [BMLazyModel class];
            initializer.initializer = ^id(id sender){
                BMProject *project = [BMProject new];
                project.name = @"BloodMagic";
                project.lazyModel = sender;
                return project;
            };
            [initializer registerInitializer];
        });

        it(@"should load custom objects", ^{
            subject.project.name should equal(@"BloodMagic");
        });

        it(@"should have sender", ^{
            subject.project.lazyModel should equal(subject);
        });

        it(@"should consider container class", ^{
            BMAnotherLazyModel *anotherLazyModel = [BMAnotherLazyModel new];
            anotherLazyModel.user.name should be_nil;
        });

        it(@"should have NSObject container by default", ^{
            BMInitializer *initializer = [BMInitializer lazyInitializer];
            initializer.propertyClass = [BMProject class];
            initializer.initializer = ^id(id sender){
                BMProject *project = [BMProject new];
                project.name = @"BloodMagic";
                return project;
            };
            [initializer registerInitializer];

            BMAnotherLazyModel *anotherLazyModel = [BMAnotherLazyModel new];
            anotherLazyModel.project.name should equal(@"BloodMagic");
        });

        context(@"protocols", ^{

            __block BMInitializer *initializer = nil;

            describe(@"property with protocol", ^{

                beforeEach(^{
                    initializer = [BMInitializer lazyInitializer];
                    initializer.protocols = @[@protocol(BMLazyTestProtocol)];
                    initializer.initializer = ^id(id sender) {
                        BMTestProtocolModel *model = [BMTestProtocolModel new];
                        model.testString = @"Test";
                        return model;
                    };
                    [initializer registerInitializer];
                });

                it(@"not nil", ^{
                    subject.propertyWithProtocol should_not be_nil;
                });

                it(@"conforms to protocol", ^{
                    [subject.propertyWithProtocol conformsToProtocol:@protocol(BMLazyTestProtocol)] should be_truthy;
                });

                it(@"initialized with actual value", ^{
                    subject.propertyWithProtocol.testString should equal(@"Test");
                });

            });

        });

        context(@"inheritance", ^{
            __block BMInheritedModel *inheritedModel = nil;

            describe(@"inherited lazyness", ^{
                beforeEach(^{
                    inheritedModel = [BMInheritedModel new];
                });
                afterEach(^{
                    inheritedModel = nil;
                });

                it(@"not nil", ^{
                    inheritedModel.user should_not be_nil;
                });
            });
        });

        context(@"excluding", ^{
            __block BMInheritedExcludedModel *excludedModel = nil;

            describe(@"inherited lazyness", ^{
                beforeEach(^{
                    excludedModel = [BMInheritedExcludedModel new];
                });
                afterEach(^{
                    excludedModel = nil;
                });

                it(@"super's property is not nil", ^{
                    excludedModel.user should_not be_nil;
                });
                
                it(@"doesn't instntiate exluded property", ^{
                    ^{[excludedModel admin];} should raise_exception([NSException class]);
                });
            });
        });

    });

    context(@"custom initializer", ^{
        beforeEach(^{
            [BMInitializer setDefaultInitializer:nil];
        });

        afterEach(^{
            [BMInitializer restoreDefaultInitializer];
        });

        describe(@"should not", ^{
            
            it(@"instantiate objects", ^{
                subject.nilObject should be_nil;
            });
            
        });

    });

});

SPEC_END
