
![Image of InAppManagerHeader](https://github.com/greenSyntax/SwiftInAppManager/blob/master/in_App_header.png)
===================

Neither it's a mamomth project nor I'm clamimg it. Just a REST API for feedback Service.

## Header 
Every API Request has this as a Header.
```
Content-type:application/json
```

## Ednpoints
#### [GET] /feedbacks

It's a DISPLAY API 

```
http://[BASEURL]/feedbackApp/feedbacks
```
#### Response
JSON would be like this, when your request for /feedback API.

```json
{
    "response_code": 200,
    "response_status": "OK",
    "response_data": [
        {
            "feedback_id": "34",
            "user_name": "nikx",
            "feedback_text": "Hi This is Nikhil. And, &lt;\/html&gt;Im Working in InnovationM",
            "user_mail": "NULL",
            "time_stamp": "2017-03-07 06:53:24",
            "processing_status": "0",
            "user_ip": null,
            "os_type": null,
            "user_device": null
        }
    ]
}	
```





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