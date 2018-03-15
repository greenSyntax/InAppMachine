//
//  InAppProduct.swift
//  InAppManager
//
//  Created by Abhishek Kumar Ravi on 15/03/18.
//

import Foundation
import StoreKit

/// An InApp Model which you'll get on every InApp Product Request. It's a wrap around SKProduct
public struct InAppProduct {

    var productInstance:SKProduct?
    var productId:String?
    var productTitle:String?
    var productDescription:String?
    var productLocale:Locale?
    var productPrice:NSDecimalNumber?
}
