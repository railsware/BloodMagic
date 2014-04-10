#import "SpecHelper.h"
#import "BMStandardStorage.h"
#import "BMCustomStorage.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BMPreferenceSpec)

describe(@"BMPreference", ^{
    __block NSUserDefaults *userDefaults = nil;

    context(@"Standard Storage", ^{
        __block BMStandardStorage *storage = nil;

        beforeEach(^{
            userDefaults = [NSUserDefaults standardUserDefaults];
            storage = [BMStandardStorage new];
        });

        afterEach(^{
            storage = nil;
            userDefaults = nil;
        });

        describe(@"should store value", ^{
            NSString *preference = @"SomePreference";

            it(@"in standardUserDefaults", ^{
                storage.preference = preference;
                storage.preference should equal(preference);

                [userDefaults objectForKey:@"preference"] should equal(preference);
            });

        });
    });

    context(@"Custom storage", ^{
        __block BMCustomStorage *storage = nil;

        beforeEach(^{
            userDefaults = [[NSUserDefaults alloc] initWithUser:@"AlexDenisov"];
            storage = [BMCustomStorage new];
            storage.userDefaults = userDefaults;
        });

        afterEach(^{
            storage = nil;
            userDefaults = nil;
        });

        describe(@"should store value", ^{
            NSString *preference = @"SomeCustomPreference";

            it(@"in standardUserDefaults", ^{
                storage.preference = preference;
                storage.preference should equal(preference);

                [userDefaults objectForKey:@"preference"] should equal(preference);
            });

        });

    });
    
});

SPEC_END
