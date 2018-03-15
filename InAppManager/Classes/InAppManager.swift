
import Foundation
import StoreKit

public class InAppManager: NSObject {

    fileprivate var inAppProducts:[String]?

    //Private Closures
    fileprivate var productsClosure:(([InAppProduct])->Void)?
    fileprivate var errorClosure:((InAppError)->Void)?
    fileprivate var paymentSuccessClosure:((InAppTransaction)->Void)?
    fileprivate var paymentFailedClosure:((InAppError)->Void)?

    public static let shared = InAppManager()
    private override init(){}

    /// This Method request InApp Products from iTunes attached to the Bundle.
    ///
    /// - Parameters:
    ///   - products: Success Closure where you will get Array of InApp Products
    ///   - error: Error when you get any error
    public func requestFor(inAppProducts:@escaping (([InAppProduct])->Void),_ hasError error:@escaping (InAppError?)->Void){

        productsClosure = products
        errorClosure = error

        if SKPaymentQueue.canMakePayments(){

            let productsIdentifer = getInAppProducts()
            let productRequest = SKProductsRequest(productIdentifiers: productsIdentifer as! Set<String>)

            productRequest.delegate = self
            productRequest.start()
        }
        else{

            //Device is Not capable of making Payment
            error(InAppError.deviceNotCapableForInAppPayment)
        }
    }

    /// Purchase Product
    ///
    /// - Parameter requestProduct: InAppProduct Model
    func purcahseFor(product requestProduct:InAppProduct){

        let payement = SKPayment(product: requestProduct.productInstance!)
        SKPaymentQueue.default().add(payement)
    }

}

extension InAppManager {

    /// This method returns Set collection of all your unique Product IDs which are stings
    ///
    /// - Returns: Set of Product IDs
    fileprivate func getInAppProducts()->NSSet?{

        if inAppProducts != nil{

            return NSSet(array: inAppProducts!)
        }
        else{
            return nil
        }
    }

    fileprivate func purchasedProduct(transaction: SKPaymentTransaction) {

        if let paymentSuccessClosure = paymentSuccessClosure{

            //onSuccess
            paymentSuccessClosure(prepareTransactionReceipt(transaction: transaction))
        }
    }

    fileprivate func failedPurchase(transaction: SKPaymentTransaction) {

        if let paymentFailedClosure = paymentFailedClosure{

            //onFailure
            paymentFailedClosure(.errorWhilePurchase)
        }
    }
}

extension InAppManager: SKProductsRequestDelegate {

    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

        var inAppProductsArray = [InAppProduct]()

        if response.products.count != 0{

            for product:SKProduct in response.products{

                //TODO Use Map function and Reduce Code
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

            if let productsClosure = productsClosure{

                //Success Closure
                productsClosure(inAppProductsArray)
            }

        }
        else{

            //onFail
            if let errorClosure = errorClosure{

                errorClosure(InAppError.NoProducts)
            }
        }

        //When Product Identifers are Invalid.
        // Or, Your iTunes is not setup properly. You've to setup the Aggreemnet, Tax and Banking Section befor you release any Paid InApp Product.
        // Note: Add Card and Basic Bank Details in iTunes-Aggrement, Tax and Banking Section
        if response.invalidProductIdentifiers.count != 0 {

            //When ProductsID are Invalid
            print(response.invalidProductIdentifiers)

            if let errorClosure = errorClosure{

                errorClosure(InAppError.InvalidProductIdentifers)
            }
        }

    }

}

extension InAppManager: SKPaymentTransactionObserver {

    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction in transactions {

            switch transaction.transactionState {

            case .purchasing:
                print("InApp: Purchasing ...")
                break

            case .purchased:
                print("InApp: Successfully Purachsed")
                SKPaymentQueue.default().finishTransaction(transaction)

                purchasedProduct(transaction: transaction)
                break

            case .restored:
                print("InApp: Restored ...")
                break

            case .failed:
                print("InApp: Purchased Failed")
                SKPaymentQueue.default().finishTransaction(transaction)

            case .deferred:
                print("InApp: Deffered ...")
                return
            }
            
        }

    }


    public func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {

        //TODO
    }

}
