# InAppMachine

[![CI Status](https://img.shields.io/travis/greenSyntax/InAppMachine.svg?style=flat)](https://travis-ci.org/greenSyntax/InAppMachine)
[![Version](https://img.shields.io/cocoapods/v/InAppMachine.svg?style=flat)](https://cocoapods.org/pods/InAppMachine)
[![License](https://img.shields.io/cocoapods/l/InAppMachine.svg?style=flat)](https://cocoapods.org/pods/InAppMachine)
[![Platform](https://img.shields.io/cocoapods/p/InAppMachine.svg?style=flat)](https://cocoapods.org/pods/InAppMachine)

#### A Easy Wrapper Over StoreKit framework.

## Features 

**v1.1.0**
[*] Closure based API for InApp Purcahse
[*] Request , Purchase and Restore InApp Products

## Installation

InAppMachine is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InAppMachine'
```
## Create on iTunes Connect

**Step1.**
Login to your iTunes  Account.

**Step2.**
Switch to 'My Apps' and open your app.

**Step3.**
Go to 'Features' section of the app and create InApp Product.

[Incomplete]


## Intialize InAppMachine

**Step1:** 
InAppMachine follows singleton, so first you shoud access its singleton object rather than creating one,

```swift

import UIKit
import InAppMachine

class ViewController: UIViewController {

// Add This One
let inappMachine = InAppMachine.shared

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

}
    
}

```

**Step2:**

Now, You have to tell InAppMachine about the Product ID(s) which you have made on iTunes connect.
Say, you have created a consumable product named 'co.in.greensyntax.restman.developer.program'

So, you have to adopt 'InAppPurchaseSource' protocol and satisfy the stubs (i.e. products).

```swift

import UIKit
import InAppMachine

class ViewController: UIViewController, InAppPurchaseSource {

// Change as per your ProductID
var products: [String] = ["co.in.greensyntax.restman.developer.program"]

let inappMachine = InAppMachine.shared

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    // Next, I have set the dataSource with the instance of my object.
    inappMachine.dataSource = self
}

}
```

## Request Products

**Step3:**
Now, we'll check wheather our ProductID are valid or not. So, we'll call the request method for checking the validity of product.

```swift

inappMachine.requestFor(inAppProducts: { (products) in
    
    //onSuccess
    for product in products {
    
        // Valid Product Deatils
        print(product.description)
    }
}) { (error) in
    
    //onError you'll get an error of type InAppError
    print(error?.localizedText)
}

```
With these details, you can prepare your Purchase View where you can show Products Details.

## Purchase 

**Step4:**

And, On Purchase affirmation, you can initiate purchase event with valid Product object. 
For purchasing, you need an instance of 'InAppProduct' which you got on InApp request call (step3). 

```swift

self.inappMachine.purcahseFor(product: product, onSuccess: { (transaction: InAppTransaction) in

    //onSuccessfull Transaction
    print(transaction.description)

}, onFailed: { (error) in

    //onFailed Transaction
    print(error)
})

```

## Restore

## Contributor 

[Abhishek Kumar Ravi](https://greensyntax.co.in)

## License

InAppMachine is available under the MIT license. See the LICENSE file for more info.
