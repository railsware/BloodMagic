BloodMagic FAQ
=====

 - [How to start?](https://github.com/railsware/BloodMagic/blob/master/FAQ.md#how-to-start)
 - [Can I use BM with class' extension?](https://github.com/railsware/BloodMagic/blob/master/FAQ.md#can-i-use-bm-with-class-extension)
 - [Can I use multiple attributes with one class?](https://github.com/railsware/BloodMagic/blob/master/FAQ.md#can-i-use-multiple-attributes-with-one-class)

=====

### How to start?

To start using BM you just need to add protocol to your class:

```objectivec

#import <BloodMagic/Lazy.h>

@interface ViewController : UIViewController
  <BMLazy>

@property (nonatomic, strong) ProgressViewService *progressViewService;

@end

```

and mark your property as `@dynamic`

```objectivec

@implementation ViewController

@dynamic progressViewService;

@end

```

That's it, magic will be injected into `ViewController` without any additional efforts.


### Can I use BM with class' extension?

Yes. It doesn't matter where actually protocol defined.

Also, using of BM in such way will keep your interface clean.

```objectivec

// ViewController.h
@interface ViewController : UIViewController

@property (nonatomic, strong) ProgressViewService *progressViewService;

@end

```

```objectivec

// ViewController.m

#import <BloodMagic/Lazy.h>

@interface ViewController ()
  <BMLazy>

@end

@implementation ViewController

@dynamic progressViewService;

@end

```

### Can I use multiple attributes with one class?

Yes. Each module provides macro definition which helps BM to determine which attribute applies on property

```objectivec

#import <BloodMagic/Lazy.h>
#import <BloodMagic/Partial.h>

@interface ViewController : UIViewController
 <BMLazy,
 BMPartial>

@property (nonatomic, strong) ProgressViewService *progressViewService;
@property (nonatomic, strong) HeaderView *headerView;

@end

@implementation ViewController

@lazy(progressViewService)
@partial(headerView)

@end

```

In this case `progressViewService` and `headerView` would behave like `lazy` and `partial` respectively.

_Note:_ In case of using two or more BM modules without such special macroses - behaviour is undefined, because it's impossible to determine relation between property and it's attribute.


