# CrashlyticsRecorder

[![Version](https://img.shields.io/cocoapods/v/CrashlyticsRecorder.svg?style=flat)](http://cocoapods.org/pods/CrashlyticsRecorder)
[![License](https://img.shields.io/cocoapods/l/CrashlyticsRecorder.svg?style=flat)](http://cocoapods.org/pods/CrashlyticsRecorder)
[![Platform](https://img.shields.io/cocoapods/p/CrashlyticsRecorder.svg?style=flat)](http://cocoapods.org/pods/CrashlyticsRecorder)

The Crashlytics platform is unable to be included as a transitive dependency, meaning you are unable to use it in a framework that will be included in an application that uses Crashlytics. This library uses dependency injection to create a wrapper around the `Crashlytics` and `Answers` classes for use in other frameworks.

## Functionality

- [x] Set custom keys on crash reports
- [x] Record non-fatal errors 
- [x] Record Swift `ErrorType` errors with custom keys
- [x] Logging using `CLS_LOG`
- [x] Record events using Answers
- [ ] Logging of custom exceptions

## Usage

### In Frameworks

`CrashlyticsRecorder` and `AnswersRecorder` act as wrappers for `Crashlytics` and `Answers` respectively. To use these classes, include this pod as a dependency for your framework. If you are using [CocoaPods](http://cocoapods.org), this can be accomplished by adding the following lines to your Podfile and podspec.

Podfile

```ruby
pod 'CrashlyticsRecorder'
```

podspec

```ruby
s.dependency 'CrashlyticsRecorder'
```

You can then use `CrashlyticsRecorder.sharedInstance` and `AnswersRecorder.sharedInstance` in your framework.

### In Applications

In order for `CrashlyticsRecorder` to work properly in your application's included frameworks, you will need to take a few steps.

1. Include the `CrashlyticsAdapter.swift` file in your application target. Alternatively, you can copy the following code into your `AppDelegate`, or anywhere in your application target.

```swift
import Crashlytics
import CrashlyticsRecorder

extension Crashlytics: CrashlyticsProtocol {
    public func log(format: String, args: CVaListPointer) {
        #if DEBUG
            CLSNSLogv(format, args)
        #else
            CLSLogv(format, args)
        #endif
    }
}

extension Answers: AnswersProtocol { }

```

2. Create the `CrashlyticsRecorder` and `AnswersRecorder` shared instances in your `AppDelegate` after setting up `Crashlytics`.

```swift
public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Fabric.with([Crashlytics()])
    CrashlyticsRecorder.createSharedInstance(crashlytics: Crashlytics.sharedInstance())
    AnswersRecorder.createSharedInstance(answers: Answers.self)
}
```

## Requirements

You must have a `Fabric` account to use `Crashlytics` and the `CrashlyticsRecorder` in your applications.

## Author

Anthony Miller, anthony@app-order.com

## License

CrashlyticsRecorder is available under the MIT license. See the LICENSE file for more info.