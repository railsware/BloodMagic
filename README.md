## BloodMagic 
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png) &nbsp;
![Build status](https://api.travis-ci.org/railsware/BloodMagic.png) &nbsp; ![Version](https://cocoapod-badges.herokuapp.com/v/BloodMagic/badge.png) &nbsp; ![Platform](https://cocoapod-badges.herokuapp.com/p/BloodMagic/badge.png)

Objective-C is a powerful language, but sometimes it lacks of custom property attributes, like these:

```objectivec
@property (nonatomic, strong, bm_lazy) ProgressViewService *progressView;
@property (nonatomic, strong, bm_partial) HeaderView *headerView;
@property (nonatomic, strong, bm_final) NSString *almostImmutable;

@property (nonatomic, strong, storable) NSString *authToken;

@property (nonatomic, strong, copyable) NSString *username;
@property (nonatomic, strong, copyable) NSString *email;

@property (nonatomic, strong, anything_you_want) AwesomeView *someAwesomeView;
```

We can't implement these attributes without hacking on `clang`, but fortunately, we're able to achieve these effects by means of BloodMagic' spells

[FAQ](https://github.com/railsware/BloodMagic/blob/master/FAQ.md)

[Blog-post](http://l.rw.rw/dibm)

[Presentation](https://speakerdeck.com/alexdenisov/bloodmagic) by [AlexDenisov](https://github.com/AlexDenisov)

[Presentation](https://speakerdeck.com/0xc010d/dependency-injection-ftw) by [Ievgen Solodovnykov](https://github.com/0xc010d)

### Embark on the Dark

Simple installation via [CocoaPods](http://cocoapods.org/):

```ruby
  pod 'BloodMagic', :git => 'https://github.com/railsware/BloodMagic.git'
```

### Available Spells

[Lazy Initialization](https://github.com/railsware/BloodMagic#lazy-initialization)

[Dependency Injection](https://github.com/railsware/BloodMagic#dependency-injection)

[Partial Views](https://github.com/railsware/BloodMagic#partial-views)

[Assign-once properties](https://github.com/railsware/BloodMagic#assign-once-properties)

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

_Note:_ `containerClass` doesn't apply on derived classes, to achieve such behavior you should specify `containerClass` explicitly.

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

##### Lazy loading hooks

`BMLazy` module provides a hook system to catch the object creation.
To enable these hooks just create instance method named `propertyNameInjected:`.

For example:
```objectivec
@implementation ViewController

@lazy(progressViewService)

- (void)progressViewServiceInjected:(ProgressViewService *service)
{
    service.title = self.title;
}

@end
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

#### Assign-once properties

```ruby
  pod 'BloodMagic/Final', :git => 'https://github.com/railsware/BloodMagic.git'
```

Java provides [final](http://en.wikipedia.org/wiki/Final_(Java)) keyword, which determines that value can't be changed.

From now this feature available in Objective-C, via BloodMagic.

```objectivec

#import <BloodMagic/Final.h>

@interface FinalizedObject : NSObject
    <BMFinal>

@property (nonatomic, strong, bm_final) NSString *almostImmutableProperty;

@end

@implementation FinalizedObject

@dynamic almostImmutableProperty;

@end

// ...

FinalizedObject *object = [FinalizedObject new];
object.almostImmutableProperty = @"Initial value"; // all is OK
object.almostImmutableProperty = @"Another value"; // exception will be thrown

```

### Side effects (aka bugs)

BloodMagic may have side effects, if you find one, please, open issue or send us a pull request.

Those actions will help us to protect you from mutilation.

