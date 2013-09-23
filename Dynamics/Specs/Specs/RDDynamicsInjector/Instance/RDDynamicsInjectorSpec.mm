#import "SpecHelper.h"
#import "RDDynamicsInjector.h"
#import "RDFatDynamicModel.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

CDR_EXT
Tsuga<RDDynamicsInjector>::runInstance(^{
    __block RDDynamicsInjector *injector = nil;

    beforeEach(^{
        injector = subject();

        [injector injectDynamicsInto:@protocol(RDFatTestProtocol)];
    });

    describe(@"accessors/mutators injected", ^{
        __block RDFatDynamicModel *model = nil;
        NSString *testObject = @"Hello, Dynamics";

        beforeEach(^{
            model = [RDFatDynamicModel new];
        });

        it(@"nonatomic copy", ^{
            ^{
                model.nonatomicCopyObject = testObject;
                model.nonatomicCopyObject should equal(testObject);
            } should_not raise_exception;
        });

        it(@"nonatomic retain", ^{
            ^{
                model.nonatomicRetainObject = testObject;
                model.nonatomicRetainObject should equal(testObject);
            } should_not raise_exception;
        });

        it(@"atomic copy", ^{
            ^{
                model.atomicCopyObject = testObject;
            } should_not raise_exception;
            model.atomicCopyObject should equal(testObject);
        });

        it(@"atomic retain", ^{
            ^{
                model.atomicRetainObject = testObject;
                model.atomicRetainObject should equal(testObject);
            } should_not raise_exception;
        });

        it(@"char", ^{
            ^{
                model.charProperty = -'A';
                model.charProperty should equal(-'A');
            } should_not raise_exception;
        });

        it(@"unsigned char", ^{
            ^{
                model.unsignedCharProperty = 'A';
                model.unsignedCharProperty should equal('A');
            } should_not raise_exception;
        });

        it(@"short", ^{
            ^{
                model.shortProperty = -12112;
                model.shortProperty should equal(-12112);
            } should_not raise_exception;
        });

        it(@"unsigned short", ^{
            ^{
                model.unsignedShortProperty = 12112;
                model.unsignedShortProperty should equal(12112);
            } should_not raise_exception;
        });

        it(@"int", ^{
            ^{
                model.intProperty = -1231212323;
                model.intProperty should equal(-1231212323);
            } should_not raise_exception;
        });

        it(@"unsigned int", ^{
            ^{
                model.unsignedIntProperty = 12312311U;
                model.unsignedIntProperty should equal(12312311U);
            } should_not raise_exception;
        });

        it(@"long", ^{
            ^{
                model.longProperty = -1123123123L;
                model.longProperty should equal(-1123123123L);
            } should_not raise_exception;
        });

        it(@"unsigned long", ^{
            ^{
                model.unsignedLongProperty = 1231231231UL;
                model.unsignedLongProperty should equal(1231231231UL);
            } should_not raise_exception;
        });

        it(@"long long", ^{
            ^{
                model.longLongProperty = -1231231231LL;
                model.longLongProperty should equal(-1231231231LL);
            } should_not raise_exception;
        });

        it(@"unsigned long long", ^{
            ^{
                model.unsignedLongLongProperty = 1231231313ULL;
                model.unsignedLongLongProperty should equal(1231231313ULL);
            } should_not raise_exception;
        });

        it(@"float", ^{
            ^{
                model.floatProperty = 42.42f;
                model.floatProperty should equal(42.42f);
            } should_not raise_exception;
        });

        it(@"double", ^{
            ^{
                model.doubleProperty = 42.42;
                model.doubleProperty should equal(42.42);
            } should_not raise_exception;
        });

        it(@"BOOL", ^{
            ^{
                model.boolProperty = YES;
                model.boolProperty should equal(YES);
            } should_not raise_exception;
        });

    });

});

