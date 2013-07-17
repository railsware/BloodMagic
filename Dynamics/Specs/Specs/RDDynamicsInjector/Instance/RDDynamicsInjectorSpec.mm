#import "SpecHelper.h"
#import "RDDynamicsInjector.h"
#import "RDTestProtocol.h"
#import "RDFatDynamicModel.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

CDR_EXT
Tsuga<RDDynamicsInjector>::runInstance(^{
    __block RDDynamicsInjector *injector = nil;

    beforeEach(^{
        injector = subject();

        [injector injectDynamicsInto:@protocol(RDTestProtocol)];
    });

    describe(@"accessors injected", ^{
        __block RDFatDynamicModel *model = nil;
        NSString *testObject = @"Hello, Dynamics";

        beforeEach(^{
            model = [RDFatDynamicModel new];
        });

        it(@"nonatomic copy", ^{
            ^{
                model.nonatomicCopyObject = testObject;
            } should_not raise_exception;
        });

        it(@"nonatomic retain", ^{
            ^{
                model.nonatomicRetainObject = testObject;
            } should_not raise_exception;
        });

        it(@"atomic copy", ^{
            ^{
                model.atomicCopyObject = testObject;
            } should_not raise_exception;
        });

        it(@"atomic retain", ^{
            ^{
                model.atomicRetainObject = testObject;
            } should_not raise_exception;
        });

    });
});

