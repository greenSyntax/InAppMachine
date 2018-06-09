//
//  ViewController.swift
//  InAppMachine
//
//  Created by greenSyntax on 05/25/2018.
//  Copyright (c) 2018 greenSyntax. All rights reserved.
//

import UIKit
import InAppMachine

class ViewController: UIViewController, InAppPurchaseSource {
    
    //"co.in.greensyntax.restman.developer.program",
    
    var products: [String] = ["co.in.greensyntax.restman.plan.enterprise"]

    let inappMachine = InAppMachine.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inappMachine.dataSource = self
        requestForProducts()
        
    }
    func purchaseProduct(product: InAppProduct) {
        
        self.inappMachine.purcahseFor(product: product, onSuccess: { (transaction: InAppTransaction) in
            
            print(transaction.description)
            
        }, onFailed: { (error) in
            
            print(error)
        })
    }
    
    
    func restoreProduct(product: InAppProduct) {
        
    }
    
    func requestForProducts() {
        inappMachine.requestFor(inAppProducts: { (products) in
            
            for product in products {
                
                print(product.description)
                
                // Purchase Product
                self.purchaseProduct(product: product)
            }
        }) { (error) in
            
            print(error?.localizedText)
        }
    }
    
    func getRecipts() {
        
        // Get Recipts Data to Validate the Purchase
        let recipts = inappMachine.getReciptData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

