//
//  InAppTransaction.swift
//  InAppManager
//
//  Created by Abhishek Kumar Ravi on 15/03/18.
//

import Foundation
import StoreKit

/// InApp Transaction Model which wraps the SKPaymentTransaction
public struct InAppTransaction {

    var transactionDate:Date?
    var transactionIdentifier:String?
}
