# InAppManager

[![CI Status](http://img.shields.io/travis/greenSyntax/InAppManager.svg?style=flat)](https://travis-ci.org/greenSyntax/InAppManager)
[![Version](https://img.shields.io/cocoapods/v/InAppManager.svg?style=flat)](http://cocoapods.org/pods/InAppManager)
[![License](https://img.shields.io/cocoapods/l/InAppManager.svg?style=flat)](http://cocoapods.org/pods/InAppManager)
[![Platform](https://img.shields.io/cocoapods/p/InAppManager.svg?style=flat)](http://cocoapods.org/pods/InAppManager)

## Features

## Steup InApp Products in iTunes

## Requirements

## Installation

InAppManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InAppManager'
```

## Code

#### **Initialize Products**
+ I'm assuming you have InApp Products Identifier with you,

```swift
let products = ["com.greenstore.silverPlan" , "com.greenstore.goldPlan", "com.greenstore.platinumPlan"]
```

#### **Request Products**
+ Request for array of InApp Products. In Response you will get an Array of Model Object which has *title*, *description* and *locale price* .

```swift
inAppManager.requestForInAppProducts(products: { (products) in

// List of InApp Products
print(products)

}) { (error) in

// Error while getting Products
}
```

#### **Purcahse Product**
+ If you want to request for purchase. Then, you must have a product model object.

```swift
//Purcahse Product
inAppManager.purchaseProduct(product: product.productInstance!, onSuccess: { (transaction) in

//onSuccessfull transaction

}) { (error) in

//onError

}

```


## Contributors

[Abhishek Kumar Ravi](https://greensyntax.co.in)

(ab.abhishek.ravi@gmail.com)[mailto:ab.abhishek.ravi@gmail.com]

## License

InAppManager is available under the MIT license. See the LICENSE file for more info.
