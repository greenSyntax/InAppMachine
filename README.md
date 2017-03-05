
![Image of InAppManagerHeader](https://github.com/greenSyntax/SwiftInAppManager/blob/master/in_App_header.png)
===================

InAppManager is wrapper class around **StoreKit** framework. It's a manager which performs InApp tasks. 
Sounds boring  :confused: , but mark my words 
> InAppManager 'll layer down your StoreKit codes.

## Installation
Drag **InAppManger.swift** class, **InAppModel.swift** and **InAppTransaction.swift**  model class in your project.


## Usage

#### **Intialization**
1. Instance InAppManager.swift
```swift
let inAppManager = InAppManager.shared    
```
2.  Configure InAppManager with Product IDs 
```swift
//InApp Product IDs
let inAppProductsId:[String] = ["BLAH", "BLAH", "BLAH"];

//Configure
inAppManager.configureInAppProducts(nameOfProducts: inAppProductsId)

inAppManager.delegate = self
```

#### **Request Products**
1.  Request for array of InApp Products. In Response you will get an Array of Model Object which has *title*, *description* and *locale price* . 

```swift
inAppManager.requestForInAppProducts()
```
2. And, Then you've two delegate methods depending upon their Response Status.

```swift
func onSuccessInAppProductRequest(products:[InAppProduct]){
	 // Array of InApp Product Model
}
   
func onFailInAppProductRequest(errorMessage:String?){ 
	 //When App fails to load InApp products 
}
```

#### **Purcahse Product**
1. If you want to request for purchase. Then, you must have a product model object. 

```swift

```


## Flow Diagram

![Image of Flow_Diagram](https://github.com/greenSyntax/SwiftInAppManager/blob/master/InAppManger.swift.png)

##Liscence
This project is under MIT Liscence. 