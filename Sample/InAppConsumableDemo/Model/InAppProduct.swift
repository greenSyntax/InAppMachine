//
//  InAppProduct.swift
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
