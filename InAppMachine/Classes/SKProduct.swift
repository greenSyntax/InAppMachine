//
//  SKProduct.swift
//  InAppManager
//
//  Created by Abhishek Kumar Ravi on 15/03/18.
//

import Foundation
import StoreKit

extension SKProduct {

    /// Method returns localized Price instead of the Value.
    /// Say, You producy Price is 10 and, Localized Price is 10$ (depending upon your Region)
    ///
    /// - Returns: Localized Price in String
    public func localizedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)!
    }
}
