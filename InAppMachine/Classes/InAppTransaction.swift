//
//  InAppTransaction.swift
//  InAppManager
//
//  Created by Abhishek Kumar Ravi on 15/03/18.
//

import Foundation
import StoreKit

/// InApp Transaction Model which wraps the SKPaymentTransaction
public struct InAppTransaction: CustomStringConvertible, Equatable {

    public var transactionDate: Date
    public var transactionIdentifier: String
    
    public var description: String {
        return "\n Transaction Date: \(transactionDate) \n Transaction Identifier: \(transactionIdentifier)"
    }
    
    public static func == (lhs: InAppTransaction, rhs: InAppTransaction) -> Bool {
        return lhs.transactionIdentifier == rhs.transactionIdentifier
    }
}
