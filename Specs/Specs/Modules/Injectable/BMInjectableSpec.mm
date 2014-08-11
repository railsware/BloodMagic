#import "BMInjectable.h"
#import "BMInjectableModel.h"
#import "BMInjectableBaseModel.h"
#import "BMInjectableDerivedModel.h"
#import "BMInjectableDerivedExtendedModel.h"
#import "BMAnotherLazyModel.h"
#import "BMInjectableDerivedModel.h"
#import "BMProject.h"
#import "BMUser.h"
#import "BMInjectableTestProtocol.h"
#import "BMTestProtocolModel.h"
#import "BMInheritedModel.h"
#import "BMInheritedExcludedModel.h"

#import "BMInitializer+Injectable.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMInjectableSpec)

describe(@"BMInjectable", ^{

    __block BMInjectableModel *subject = nil;
    
    beforeEach(^{
        subject = [BMInjectableModel new];
    });
    
    afterEach(^{
        subject = nil;
    });
    
    context(@"nil values without initializers", ^{

        context(@"direct access", ^{

            it(@"Foundation objects", ^{
                subject.stringProperty should be_nil;
            });

            it(@"custom objects", ^{
                subject.user should be_nil;
            });

        });

        context(@"KVC", ^{

            it(@"Foundation objects", ^{
                [subject valueForKey:@"stringProperty"] should be_nil;
            });

            it(@"custom objects", ^{
                [subject valueForKey:@"user"] should be_nil;
            });

        });

        describe(@"subclasses", ^{

            it(@"should inherit behavior", ^{
                BMInjectableBaseModel *base = [BMInjectableBaseModel new];
                base.test should be_nil;

                BMInjectableDerivedModel *derived = [BMInjectableDerivedModel new];
                derived.test should be_nil;
            });

            it(@"should support lazy classes inherited from another lazy classes", ^{
                BMInjectableDerivedModel *derivedLazy = [BMInjectableDerivedModel new];
                derivedLazy.test should be_nil;
            });

            it(@"should support lazy classes with added properties inherited from another lazy classes", ^{
                BMInjectableDerivedExtendedModel *derivedExtended = [BMInjectableDerivedExtendedModel new];
                derivedExtended.test should be_nil;
                derivedExtended.user should be_nil;
            });

        });

    });

    context(@"custom values", ^{

        beforeEach(^{
            BMInitializer *initializer = [BMInitializer injectableInitializer];
            initializer.propertyClass = [BMProject class];
            initializer.containerClass = [BMInjectableModel class];
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
            BMInitializer *initializer = [BMInitializer injectableInitializer];
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
                    initializer = [BMInitializer injectableInitializer];
                    initializer.protocols = @[@protocol(BMInjectableTestProtocol)];
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

});

SPEC_END
