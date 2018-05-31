//
//  Recipts.swift
//  InAppManager
//
//  Created by Abhishek Kumar Ravi on 15/03/18.
//

import Foundation


extension InAppMachine {

    /// Method returns the Receit Data from your App Bundle.
    ///
    /// - Returns: Encrpted form of String
    public func getReciptData()->String?{

        if let reciptUrl = Bundle.main.appStoreReceiptURL{
            let receiptData = try? Data(contentsOf: reciptUrl)
            if receiptData != nil{
                return receiptData?.base64EncodedString(options: .init(rawValue: 0))
            }
        }

        return nil
    }

}
