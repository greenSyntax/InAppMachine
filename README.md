InAppManager.swift
===================

InAppManager is wrapper class around **StoreKit** framework. It's a manager which performs InApp tasks. 
Sounds boring  :confused: , but mark my words 
> InAppManager 'll layer down your StoreKit codes.

## Installation
Drag **InAppManger.swift** class, **InAppModel.swift** and **InAppTransaction.swift**  model class in your project.


## Usage
1.  Instance InAppManager.swift
	```
    let inAppManager = InAppManager.shared
    
    ```
2.  Configure InAppManager with Product IDs 
```
//InApp Product IDs
let inAppProductsId:[String] = ["BLAH", "BLAH", "BLAH"];

//Configure
inAppManager.configureInAppProducts(nameOfProducts: inAppProductsId)
```

  3. Set Delegate to self 
  
```
inAppManager.delegate = self
```

4.  Request for array of InApp Products
```
inAppManager.requestForInAppProducts()
```
5. And, Then you've two delegate methods
```
func onSuccessInAppProductRequest(products:[InAppProduct]){
	 // Array of InApp Product Model
}
   
func onFailInAppProductRequest(errorMessage:String?){ 
	 //When App fails to load InApp products 
}
```

## Contribution

##Liscence
This project is under MIT Liscence. 