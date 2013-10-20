## BloodMagic

![Build status](https://api.travis-ci.org/railsware/BloodMagic.png)

More details here: [Dependency Injection in Objective-C with Blood and Magic](http://l.rw.rw/dibm)

Objective-C is a powerful language, but sometimes it lacks of custom property attributes, like these:

```objectivec
@property (nonatomic, strong, lazy) NSMutableArray *resources;

@property (nonatomic, strong, storable) NSString *authToken;

@property (nonatomic, strong, copyable) NSString *username;
@property (nonatomic, strong, copyable) NSString *email;

@property (nonatomic, strong, anything_you_want) AwesomeView *someAwesomeView;
```

Fortunately, we're able to achieve these effects by means of BloodMagic' spells

_Note: At this time only `lazy` attribute is implemented, the rest attributes will come later_

### Embark on the Dark

Simple installation via [CocoaPods](http://cocoapods.org/):

```ruby
  pod 'BloodMagic', :git => 'https://github.com/railsware/bloodmagic'
```

### Available Spells

BloodMagic has been designed to be extensible, so few more spells will be available soon.

#### Lazy initialization

Initializes object on demand.

If you use Objective-C, then you should be familiar with this code:

```objectivec
@interface ViewController : NSObject

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

@property (nonatomic, strong) ProgressViewService *progressViewService;

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

##### Dependency Injection (kind of)

During the creation of `Lazy Initialization` spell an interesting side effect was found - kind of dependency injection.

For example, if you need to initialize `progressViewService` in a special way, a special initializer might be created:

```objectivec
BMInitializer *initializer = [BMInitializer lazyInitializer];
initializer.propertyClass = [ProgressViewService class];
initializer.containerClass = [ViewController class]; // this is optional, uses NSObject by default
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

### Creation of new spells

_TODO_

### Side effects (aka bugs)

BloodMagic may have side effects, if you find one, please, open issue or send us a pull request.

Those actions will help us to protect you from mutilation.
