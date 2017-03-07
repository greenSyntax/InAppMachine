//
//  InAppManager.swift
//  InAppConsumableDemo
//
//  Created by Abhishek Ravi on 10/12/16.
//  Copyright © 2016 InnovationM. All rights reserved.
//

import UIKit
import StoreKit

struct InAppProduct {
    
    var productInstance:SKProduct?
    var productId:String?
    var productTitle:String?
    var productDescription:String?
    var productLocale:Locale?
    var productPrice:NSDecimalNumber?
}

struct InAppTransaction {
    
    var transactionDate:Date?
    var transactionIdentifier:String?
}

class Receipt{
    
    var isTrail:Bool?
    var purchaseDate:String?
    var transactionIdentifer:String?
    var productId:String?
    var quantity:Int?
    var purchaseTimestampInMs:String?
}

protocol InAppManagerDelegate : class {
    
    //Product Request Callbacks
    func onSuccessInAppProductRequest(products:[InAppProduct])
    func onFailInAppProductRequest(errorMessage:String?)
    
    //Purchase Delegate Callbacks
    func onSuccessfulPurchaseInAppProduct(transaction:InAppTransaction)
    func onFailedPurchaseInAppProduct(errorMessage:String?)
    
}

class InAppManager: NSObject,SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var inAppProducts:[String]?
    weak var delegate:InAppManagerDelegate?
    
    static let shared:InAppManager = InAppManager()
    
    
    //MARK:- Configure
    private func getInAppProducts()->NSSet?{
        
        if inAppProducts != nil{
            
            return NSSet(array: inAppProducts!)
        }
        else{
            return nil
        }
        
    }
    
    func configureInAppProducts(nameOfProducts:[String]){
        
        inAppProducts = nameOfProducts;
        self.setInAppObservers()
    }
    
    //MARK:- Request
    func requestForInAppProducts(){
        
        if SKPaymentQueue.canMakePayments(){
            
            let productsIdentifer = getInAppProducts()
            let productRequest = SKProductsRequest(productIdentifiers: productsIdentifer as! Set<String>)
            
            //Request
            productRequest.delegate = self
            productRequest.start()
        }
        else{
            
            print("Sorry, You cant make Payment")
        }
    }
    
    //MARK:- Purchase
    func purcahseInAppProduct(requestProduct:InAppProduct){
        
        let payement = SKPayment(product: requestProduct.productInstance!)
        SKPaymentQueue.default().add(payement)
        
    }
    
    //MARK:- Delegate Methods
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse){
        
        var inAppProductsArray = [InAppProduct]()
        
        if response.products.count != 0{
            
            for product:SKProduct in response.products{
                
                var inAppProduct = InAppProduct()
                
                inAppProduct.productInstance = product
                inAppProduct.productId = product.productIdentifier
                inAppProduct.productTitle = product.localizedTitle
                inAppProduct.productDescription = product.localizedDescription
                inAppProduct.productPrice = product.price
                inAppProduct.productLocale = product.priceLocale
                
                //Append in Array
                inAppProductsArray.append(inAppProduct)
            }
            
            //onSuccess Callback
            self.delegate?.onSuccessInAppProductRequest(products: inAppProductsArray)
        }
        else{
            
            //onFail
            self.delegate?.onFailInAppProductRequest(errorMessage: "Sorry, There is some Error.")
        }
        
        if response.invalidProductIdentifiers.count != 0 {
            
            //When ProductsID are Invalid
            self.delegate?.onFailInAppProductRequest(errorMessage: "Sorry, There is some error.")
        }
    }
    

    private func setInAppObservers(){
        
        SKPaymentQueue.default().add(self)
    }

    
    //MARK:- Purchase
    func purchaseProduct(product:SKProduct){
        
        let payement = SKPayment(product: product)
        SKPaymentQueue.default().add(payement)
    }
    
    //MARK: InApp Purcahse Observers
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]){
        
        for transaction in transactions {
            
            switch transaction.transactionState {
            case SKPaymentTransactionState.purchasing:
                //Purcahsing
                print("Purachsing.....")
                break
                
            case SKPaymentTransactionState.purchased:
                
                print("Successfully Purachsed")
                SKPaymentQueue.default().finishTransaction(transaction)
                
                //Success Callback
                self.delegate?.onSuccessfulPurchaseInAppProduct(transaction: prepareTransactionReceipt(transaction: transaction))
                
                break
                
            case SKPaymentTransactionState.failed:
                
                print("Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                
                //onFail Callback
                self.delegate?.onFailedPurchaseInAppProduct(errorMessage: "Failed While Purcahse")
                break
                
            case SKPaymentTransactionState.restored:
                
                print("Restored")
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            default:
                print("Default Case")
            }
        }
    }
   
    func prepareTransactionReceipt(transaction:SKPaymentTransaction)->InAppTransaction{
        
        var inAppTransaction = InAppTransaction()
        inAppTransaction.transactionDate = transaction.transactionDate
        inAppTransaction.transactionIdentifier = transaction.transactionIdentifier
        
        return inAppTransaction
        
    }
}
