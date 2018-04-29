# SpecLeaks

[![Version](https://img.shields.io/cocoapods/v/SpecLeaks.svg?style=flat)](http://cocoapods.org/pods/SpecLeaks)
[![License](https://img.shields.io/cocoapods/l/SpecLeaks.svg?style=flat)](http://cocoapods.org/pods/SpecLeaks)
[![Platform](https://img.shields.io/cocoapods/p/SpecLeaks.svg?style=flat)](http://cocoapods.org/pods/SpecLeaks)

Create ***Unit Tests for Memory Leaks*** in **Swift**.
* ***SpecLeaks***  allows you to create tests using Quick and Nimble. 
* Write readable tests for mem leaks easily with these Quick and Nimble extensions.


[Quick and Nimble](https://github.com/Quick/Nimble) is a Unit Testing framework that allows you to write tests in a more humanly readable fashion.


## What can you Test?

* Test if an object is leaking when it is initialized.
* Test if a ViewController is leaking when its view is loaded.
* Test if a particular method is leaking


## Installation

SpecLeaks is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SpecLeaks'
```

## Example Project

The example project contains a few Unit Tests that will let you understand how to use SpecLeaks. 

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Command+U to run the sample tests.

## How to Write Tests
1. Create a Spec
2. Define a `it("action")` block
3. Create a `LeakTest` passing a block that returns the object you want to test
4. Write your expectations using `toNot(leak())` or `toNot(leakWhen())`
 
### Memory Leaks in initialization of plain Objects
```swift

class SomeObject {}

class SomeOjectTests: QuickSpec {
    override func spec() {
        describe("SomeObject") {
            describe("init") {
                it("must not leak"){
                    let someObject = LeakTest{
                        return SomeObject()
                    }

                    expect(someObject).toNot(leak())
                }
            }
        }
    }
}
```

### Memory Leaks in viewDidLoad or init of a a UIViewController


```swift

class SomeViewController : UIViewController {}

class SomeViewControllerTests: QuickSpec {

    override func spec() {
        describe("SomeViewController"){
            describe("viewDidLoad") {
                let vc = LeakTest{
                    return SomeViewController()
                }
                it("must not leak"){
                    expect(vc).toNot(leak())
                }
            }
        }
    }
}
```

### Memory Leaks when an action is called


```swift

class SomeObject{
    func doSomething(){

    }
}

class SomeOjectTests: QuickSpec {
    override func spec() {
        describe("SomeObject") {
            describe("doSomething") {
                it("must not leak"){

                    let someObject = LeakTest{
                        return SomeObject()
                    }

                    let doSomethingIsCalled : (SomeObject) -> ()  = {obj in
                         obj.doSomething()
                    }

                    expect(someObject).toNot(leakWhen(doSomethingIsCalled))
                }
            }
        }
    }
}
```
## Author

leandromperez@gmail.com, leandromperez@gmail.com

## License

SpecLeaks is available under the MIT license. See the LICENSE file for more info.
