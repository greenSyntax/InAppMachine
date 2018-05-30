//
//  InAppProduct.swift
//  InAppManager
//
//  Created by Abhishek Kumar Ravi on 15/03/18.
//

import Foundation
import StoreKit

/// An InApp Model which you'll get on every InApp Product Request. It's a wrap around SKProduct
public struct InAppProduct: CustomStringConvertible, Equatable {
    
    public var productInstance: SKProduct
    public var productId: String
    public var productTitle: String
    public var productDescription: String
    public var productLocale: Locale
    public var productPrice: NSDecimalNumber
    
    public var description: String {
        return "\n ID : \(productId) \n Title: \(productTitle) \n Description: \(productDescription) \n Locale: \(productLocale) \n Price: \(productPrice)"
    }
    
    public static func == (lhs: InAppProduct, rhs: InAppProduct) -> Bool {
        return lhs.productId == rhs.productId && lhs.productTitle == rhs.productTitle && lhs.productDescription == rhs.productDescription && lhs.productPrice == rhs.productPrice
    }
}

