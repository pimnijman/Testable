# Testable

[![CI Status](http://img.shields.io/travis/pimnijman/Testable.svg?style=flat)](https://travis-ci.org/pimnijman/Testable)
[![Version](https://img.shields.io/cocoapods/v/Testable.svg?style=flat)](http://cocoapods.org/pods/Testable)
[![License](https://img.shields.io/cocoapods/l/Testable.svg?style=flat)](http://cocoapods.org/pods/Testable)
[![Platform](https://img.shields.io/cocoapods/p/Testable.svg?style=flat)](http://cocoapods.org/pods/Testable)

A Swift mocking framework inspired by [Sinon.js](http://sinonjs.org) to easily spy on your test doubles or turn them into stubs.

## Installation

Testable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Testable'
```

## Usage

### Spyable

Let's say you have a test double and you'd like to know whether it's methods are beeing called by the code you're currently testing.

```swift
class SomeClass {
    func someMethod(foo: Int, bar: Bool) {
        //
    }
}
```

By adopting the Spyable protocol and calling recordCall(withArgs:) from the method's implementation, you'll be able to record how many times this method was called and with what arguments.

```swift
import Testable

class SomeClass: Spyable {
    func someMethod(foo: Int, bar: Bool) {
        recordCall(withArgs: foo, bar)
    }
}
```

In your tests you're now able to get a reference to the spy that keeps track of the calls to this method.

```swift
func testImplementationCallsSomeMethod() {
    let someObject = SomeClass()
    let someOtherObject = SomeOtherClass(object: someObject)
    someOtherObject.doSomething()

    let spy = someObject.spy(forMethod: "someMethod(foo:bar:)")
    XCTAssertTrue(spy.called)
    XCTAssertTrue(spy.calledOnce)
    XCTAssertEqual(spy.firstCall.args[0] as? Int, 42)
    XCTAssertEqual(spy.firstCall.args[1] as? Bool, true)
}
```

You could do the same for your test double's properties.

```swift
import Testable

class SomeClass: Spyable {
    var someProperty: Int {
        get { recordGetProperty() }
        set { recordSetProperty(withValue: newValue) }
    }
}
```

In your tests you can get a reference to the property spies.

```swift
func testImplementationGetsAndSetsProperty() {
    let someObject = SomeClass()
    let someOtherObject = SomeOtherClass(object: someObject)
    someOtherObject.doSomethingElse()

    let getPropertySpy = counter.spy(forGetProperty: "someProperty")
    XCTAssertTrue(getPropertySpy.called)
    XCTAssertTrue(getPropertySpy.calledOnce)

    let setPropertySpy = counter.spy(forSetProperty: "someProperty")
    XCTAssertTrue(setPropertySpy.called)
    XCTAssertTrue(setPropertySpy.calledOnce)
    XCTAssertEqual(setPropertySpy.firstCall.args[0] as? Int, 0)
}
```

### Stubable

Coming soon…

## Author

Pim Nijman, [@pnijman](https://twitter.com/pnijman)

## License

Testable is available under the MIT license. See the LICENSE file for more info.
