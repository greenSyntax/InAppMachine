//
//  InAppError.swift
//  InAppManager
//
//  Created by Abhishek Kumar Ravi on 15/03/18.
//

import Foundation

public enum InAppError: Error{

    case InvalidProductIdentifers(productIdentifers: [String])
    case NoProducts
    case deviceNotCapableForInAppPayment
    case errorWhilePurchase
    case declareProductID
    case failedWhileRestoring

    public var localizedText: String {

        switch self {

        case .InvalidProductIdentifers:
            return "ProductIDs which you've given are Invalid. Kindly check Product ID(s) through your iTunes App Account. \n Developer Note: Either You have give Invalid ProductID(s) or, you haven't setup the Payment Agreement in your iTunes Connect for Paid Applications."

        case .NoProducts:
            return "There is No InApp Products associted with your app. \n Developer Note: You have no registered products."

        case .deviceNotCapableForInAppPayment:
            return "Sorry, Your Device is not capable for InApp Purchase"

        case .errorWhilePurchase:
            return "There is some error while purchasing InApp Products. \n Developer Note: User have canceled"
            
        case .declareProductID:
            return "You have to set dataSource property of InAppManager. \n Developer Note: Adopt InAppPurchaseSource protocol :/"
            
        case failedWhileRestoring:
            return "Failed while restoring "
            
        }
    }
}
