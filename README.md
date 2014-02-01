## BloodMagic ![License MIT](https://go-shields.herokuapp.com/license-MIT-red.png)

![Build status](https://api.travis-ci.org/railsware/BloodMagic.png) &nbsp; ![Version](https://cocoapod-badges.herokuapp.com/v/BloodMagic/badge.png) &nbsp; ![Platform](https://cocoapod-badges.herokuapp.com/p/BloodMagic/badge.png)

More details here: [Dependency Injection in Objective-C with Blood and Magic](http://l.rw.rw/dibm)

Objective-C is a powerful language, but sometimes it lacks of custom property attributes, like these:

```objectivec
@property (nonatomic, strong, bm_lazy) ProgressViewService *progressView;
@property (nonatomic, strong, bm_partial) HeaderView *headerView;

@property (nonatomic, strong, storable) NSString *authToken;

@property (nonatomic, strong, copyable) NSString *username;
@property (nonatomic, strong, copyable) NSString *email;

@property (nonatomic, strong, anything_you_want) AwesomeView *someAwesomeView;
```

We can't implement these attributes without hacking on `clang`, but fortunately, we're able to achieve these effects by means of BloodMagic' spells

### Embark on the Dark

Simple installation via [CocoaPods](http://cocoapods.org/):

```ruby
  pod 'BloodMagic', :git => 'https://github.com/railsware/BloodMagic.git'
```

### Available Spells

[Lazy Initialization](https://github.com/railsware/BloodMagic/blob/master/README.md#lazy-initialization)

[Dependency Injection](https://github.com/railsware/BloodMagic/blob/master/README.md#dependency-injection)

[Partial Views](https://github.com/railsware/BloodMagic/blob/master/README.md#partial-views)

BloodMagic has been designed to be extensible, so few more spells will be available soon.

====

#### Lazy initialization

```ruby
pod 'BloodMagic/Lazy', :git => 'https://github.com/railsware/BloodMagic.git'
```

Initializes object on demand.

If you use Objective-C, then you should be familiar with this code:

```objectivec
@interface ViewController : UIViewController

@property (nonatomic, strong) ProgressViewService *progressViewService;

@end
```

```objectivec
- (ProgressViewService *)progressViewService
{
    if (_progressViewService == nil) {
      _progressViewService = [ProgressViewService new];
    }
  
    return _progressViewService;
}
```

But we are able to automate this routine!

Just add `BMLazy` protocol to your class:

```objectivec
@interface ViewController : NSObject
  <BMLazy>

@property (nonatomic, strong, bm_lazy) ProgressViewService *progressViewService;

@end
```

and mark any property as `@dynamic`:

```objetivec
@implementation ViewController

@dynamic progressViewService;

@end
```

Object `progressViewService` will be initialized on the first call 
```objectivec
self.progressViewService
// or
yourViewController.progressViewService
```

or when you try to get value for key

```objectivec
[self valueForKey:@"progressViewService"]
// or
[yourViewController valueForKey:@"progressViewService"]
```

By default it creates an instance with the `+new` class' method.

In this case `progressViewService` will be deallocated as a usual property.

#### Dependency Injection

```ruby
pod 'BloodMagic/Lazy', :git => 'https://github.com/railsware/BloodMagic.git'
```

During the creation of `Lazy Initialization` spell an interesting side effect was found - kind of dependency injection.

For example, if you need to initialize `progressViewService` in a special way, a special initializer might be created:

```objectivec
BMInitializer *initializer = [BMInitializer lazyInitializer];
initializer.propertyClass = [ProgressViewService class]; // optional, uses NSObject by default
initializer.containerClass = [ViewController class]; // optional, uses NSObject by default
initializer.initializer = ^id (id sender){
    return [[ProgressViewService alloc] initWithViewController:sender];
};
[initializer registerInitializer];
```

This spell is very useful when dealing with the singleton

```objectivec
BMInitializer *initializer = [BMInitializer lazyInitializer];
initializer.propertyClass = [RequestManager class];
initializer.initializer = ^id (id sender){
    static id singleInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
      singleInstance = [RequestManager new];
    });
    return singleInstance;
};
[initializer registerInitializer];
```

Thus, neither the `RequestManager` nor the class that uses it, will not be aware about his singleton nature.

Adepts of [SRP](http://en.wikipedia.org/wiki/Single_responsibility_principle) school must approve ;)

Also, you're able to use `@protocol`s as well

```objectivec
BMInitializer *initializer = [BMInitializer lazyInitializer];
initializer.protocols = @[ @protocol(ProgressViewServiceProtocol) ];
initializer.initializer = ^id (id sender){
    return [[ProgressViewService alloc] initWithViewController:sender];
};
[initializer registerInitializer];
```

#### Partial Views

```ruby
pod 'BloodMagic/Partial', :git => 'https://github.com/railsware/BloodMagic.git'
```

Instantiates view from `xib` on demand, similar to `Lazy` module.
This spell might be heplful if you have reusable views.

For example:

You need to show the same user info in table cells (`UsersListViewController`) and in some header view (`UserProfileViewController`).
It makes sense to create one `UserView.xib` associated with `UserView` class and use it through the whole app.

So it may looks like this:

```objectivec

// Cell used from UsersListViewController
// Created manually
@implementation UserViewCell
{
    UserView *_userView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSString *nibName = NSStringFromClass([UserView class]);
        UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
        _userView = [[nib instantiateWithOwner:nil options:nil] lastObject];
        [self addSubview:_userView];
    }
    return self;
}

@end

// View used from UserProfileViewController
// Created from xib
@implementation UserHeaderView
{
    UserView *_userView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSString *nibName = NSStringFromClass([UserView class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    _userView = [[nib instantiateWithOwner:nil options:nil] lastObject];
    [self addSubview:_userView];
}

@end
```

Both cases use the same, similar code.
So, BloodMagic does nothing special, just hides this boilerplate:

```objectivec

#import <BloodMagic/Partial.h>

@interface UserViewCell ()
    <BMPartial>

@property (nonatomic, strong, bm_partial) UserView *userView;

@end

@implementation UserViewCell

@dynamic userView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.userView];
    }
    return self;
}

@end

// ...

@interface UserHeaderView ()
    <BMPartial>

@property (nonatomic, strong, bm_partial) UserView *userView;

@end

@implementation UserHeaderView

@dynamic userView;

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addSubview:self.userView];
}

@end
```

### Contributors

[AlexDenisov](https://github.com/AlexDenisov)

[Ievgen Solodovnykov](https://github.com/0xc010d)

### Side effects (aka bugs)

BloodMagic may have side effects, if you find one, please, open issue or send us a pull request.

Those actions will help us to protect you from mutilation.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/railsware/bloodmagic/trend.png)](https://bitdeli.com/free "Bitdeli Badge")


