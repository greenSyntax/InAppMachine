//
//  InAppError.swift
//  InAppManager
//
//  Created by Abhishek Kumar Ravi on 15/03/18.
//

import Foundation

public enum InAppError:Error{

    case InvalidProductIdentifers
    case NoProducts
    case deviceNotCapableForInAppPayment
    case errorWhilePurchase

    public var localizedText: String {

        switch self {

        case .InvalidProductIdentifers:
            return "ProductIDs which you've given are Invalid. Kindly check Product ID(s) through your iTunes App Account"

        case .NoProducts:
            return "There is No InApp Products associted with your app"

        case .deviceNotCapableForInAppPayment:
            return "Sorry, Your Device is not capable for InApp Purchase"

        case .errorWhilePurchase:
            return "There is some error while purchasing InApp Products"

        }
    }
}
