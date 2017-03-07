
![Image of InAppManagerHeader](https://github.com/greenSyntax/SwiftInAppManager/blob/master/in_App_header.png)
===================

Neither it's a mamomth project nor I'm clamimg it. Just a REST API for feedback Service.

## Usage

#### **Intialization**
+ Instance InAppManager.swift
```swift
let inAppManager = InAppManager.shared    
```
+  Configure InAppManager with Product IDs 
```swift
//InApp Product IDs
let inAppProductsId:[String] = ["BLAH", "BLAH", "BLAH"];

//Configure
inAppManager.configureInAppProducts(nameOfProducts: inAppProductsId)

inAppManager.delegate = self
```

#### **Request Products**
+ Request for array of InApp Products. In Response you will get an Array of Model Object which has *title*, *description* and *locale price* . 

```swift
inAppManager.requestForInAppProducts()
```
+ And, Then you've two delegate methods depending upon their Response Status.

```swift
func onSuccessInAppProductRequest(products:[InAppProduct]){
	// Array of InApp Product Model
}
   
func onFailInAppProductRequest(errorMessage:String?){ 
	//When App fails to load InApp products 
}
```

#### **Purcahse Product**
+ If you want to request for purchase. Then, you must have a product model object. 

```swift
//Purcahse Product
inAppManager.purchaseProduct(product: product.productInstance!)

```

+ You have to adopt Delegate Methods for Transaction Status.
 
 ```swift
//MARK:- Step 4 : Handle Purcahse Delegates
func onSuccessfulPurchaseInAppProduct(transaction:InAppTransaction){
        
    //Your Logic when Payment Transaction is Successfull :)
}
    
func onFailedPurchaseInAppProduct(errorMessage error:String?){
        
    // Your Logic When Payemnt get Failed :(
        
}
 ```

## Flow Diagram

![Image of Flow_Diagram](https://github.com/greenSyntax/SwiftInAppManager/blob/master/InAppManger.swift.png)

##Liscence
This project is under MIT Liscence. 
