## 0.6.0

- Added support of assign-once properties, like `final` in Java: `BMFinal`

## 0.5.0

- Added support of partial views: `BMPartial`
- Added empty macro definitions: `bm_lazy`, `bm_partial`

## 0.4.4

- A lot of performance improvements
- Almost all collectors and finders use cache to achieve better performance
- BM uses STL for data caching

## 0.4.0

- Added ability to change default initializer

## 0.3.0

  - Added ability to exclude class from magic hierarchy ([details](https://github.com/railsware/BloodMagic/pull/5)), thanks to [Eugene Solodovnykov](https://github.com/0xc010d)

## 0.2.3

  - Fixed issue with subclassing
  - Small internal changes

## 0.2.2

  - Fixed bug when both, base and derived classes, directly conform to protocol (e.g. `Base<BMLazy>` and `Derived<BMLazy>`)

## 0.2.1

  - Fixed critical issue with derived dynamic properties

## 0.2.0

  - Lazy module supports `@protocol`s now

## 0.1.1

  - Fixed bug with Lazy module loading

## 0.1.0

  - Core module added
  - Initializers module added
  - Lazy module added
