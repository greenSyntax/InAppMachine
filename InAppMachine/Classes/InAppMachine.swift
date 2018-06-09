
import Foundation
import StoreKit

public protocol InAppPurchaseSource: class {
    var products: [String] {get set}
}

public class InAppMachine: NSObject {
    
    public weak var dataSource: InAppPurchaseSource?
    fileprivate var inAppProducts:[String]?

    //Private Closures
    fileprivate var productsClosure:(([InAppProduct])->Void)?
    fileprivate var errorClosure:((InAppError)->Void)?
    fileprivate var paymentSuccessClosure:((InAppTransaction)->Void)?
    fileprivate var paymentFailedClosure:((InAppError)->Void)?
    fileprivate var restoreSuccessClosure:((Bool)->Void)?
    fileprivate var restoreFailureClosure:((InAppError)->Void)?
    

    public static let shared = InAppMachine()
    private override init(){}

    fileprivate func prepareTransactionReceipt(transaction: SKPaymentTransaction) -> InAppTransaction {
        return InAppTransaction(transactionDate: transaction.transactionDate ?? Date(), transactionIdentifier: transaction.transactionIdentifier ?? "")
    }
    
    fileprivate func handleRestoreClosure() {
        
    }
    
    fileprivate func handleRestoreFailureClosure() {
        
        if let handler = restoreFailureClosure {
            handler(InAppError.NoProducts)
        }
    }
    
    /// This Method request InApp Products from iTunes attached to the Bundle.
    ///
    /// - Parameters:
    ///   - products: Success Closure where you will get Array of InApp Products
    ///   - error: Error when you get any error
    public func requestFor(inAppProducts:@escaping (([InAppProduct])->Void),_ error:@escaping (InAppError?)->Void){

        productsClosure = inAppProducts
        errorClosure = error

        if SKPaymentQueue.canMakePayments(){

            if let productsIdentifers = getInAppProducts() {
            
                let productRequest = SKProductsRequest(productIdentifiers: productsIdentifers as! Set<String>)
                
                productRequest.delegate = self
                productRequest.start()
            }
            else {
                // No Product Identifers Set
                failClosure(error: .declareProductID)
            }
        }
        else{

            //Device is Not capable of making Payment
            failClosure(error: .deviceNotCapableForInAppPayment)
        }
    }

    public func restoreProduct(forInAppProduct product: InAppProduct, onSuccess: (InAppTransaction) -> (), onFailure: (InAppError) -> ()) {
        
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    /// Purchase Product
    ///
    /// - Parameter requestProduct: InAppProduct Model
    public func purcahseFor(product requestProduct:InAppProduct, onSuccess: @escaping (InAppTransaction) -> (), onFailed: @escaping (InAppError) -> ()){

        self.paymentSuccessClosure = onSuccess
        self.paymentFailedClosure = onFailed
        
        let payement = SKPayment(product: requestProduct.productInstance)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payement)
    }

}

extension InAppMachine {

    /// This method returns Set collection of all your unique Product IDs which are stings
    ///
    /// - Returns: Set of Product IDs
    fileprivate func getInAppProducts()->NSSet?{

        if let source = dataSource{
            return NSSet(array: source.products)
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

    fileprivate func successClosure(products:  [InAppProduct]) {
        
        //Success Closure
        if let productsClosure = productsClosure{
            productsClosure(products)
        }
    }
    
    fileprivate func failClosure(error: InAppError) {
        
        if let errorClosure = errorClosure{
            //onFailure
            errorClosure(error)
        }
    }
    
    fileprivate func failedPurchase(transaction: SKPaymentTransaction) {

        if let paymentFailedClosure = paymentFailedClosure{
            //onFailure
            paymentFailedClosure(.errorWhilePurchase)
        }
    }
}

extension InAppMachine: SKProductsRequestDelegate {

    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

        var inAppProductsArray = [InAppProduct]()
        if response.products.count != 0{

            for product:SKProduct in response.products{
                
                inAppProductsArray.append(InAppProduct(productInstance: product, productId: product.productIdentifier, productTitle: product.localizedTitle, productDescription: product.localizedDescription, productLocale: product.priceLocale, productPrice: product.price))
            }

            // onSuccess
            successClosure(products: inAppProductsArray)
        }
        else{

            //onFail
           failClosure(error: .NoProducts)
        }

        //When Product Identifers are Invalid.
        // Or, Your iTunes is not setup properly. You've to setup the Aggreemnet, Tax and Banking Section befor you release any Paid InApp Product.
        // Note: Add Card and Basic Bank Details in iTunes-Aggrement, Tax and Banking Section
        if response.invalidProductIdentifiers.count != 0 {

            //When ProductsID are not valid
            failClosure(error: .InvalidProductIdentifers(productIdentifers: response.invalidProductIdentifiers))
        }

    }

}

extension InAppMachine: SKPaymentTransactionObserver {

    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction in transactions {

            switch transaction.transactionState {

            case .purchasing:
                print("InAppMachine: Purchasing ...")
                break

            case .purchased:
                print("InAppMachine: Successfully Purachsed")
                SKPaymentQueue.default().finishTransaction(transaction)

                purchasedProduct(transaction: transaction)
                break

            case .restored:
                print("InAppMachine: Restored ...")
                
                
                break

            case .failed:
                print("InAppMachine: Purchased Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                
                failedPurchase(transaction: transaction)
                break

            case .deferred:
                print("InAppMachine: Deffered ...")
                return
            }
        }

    }


    public func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {

        //TODO
    }

}
