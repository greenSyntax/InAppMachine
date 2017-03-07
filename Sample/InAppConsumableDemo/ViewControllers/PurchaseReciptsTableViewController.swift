//
//  PurchaseReciptsTableViewController.swift
//  InAppConsumableDemo
//
//  Created by Abhishek Ravi on 16/02/17.
//  Copyright © 2017 InnovationM. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseReciptsTableViewController: UITableViewController {
    
    var dataSourceRecipts:[Receipt]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Receipts"
        
        self.loadPastRecipts()
    }
    
    func loadPastRecipts(){
        
        self.showProgressWithGray()
        
        let urlPath = URL(string:"https://sandbox.itunes.apple.com/verifyReceipt")
        
        //Recipt Data
        let reciptUrl = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: reciptUrl!)
        if receiptData != nil{
            
            let receiptBody = receiptData?.base64EncodedString(options: .init(rawValue: 0))
            
            //Prepare Body
            let payload: [String: Any] = ["receipt-data": receiptBody!]
            
            let structure = ApiStructure(url: urlPath!, withType: "POST", withBody: payload)
            
            WebServiceManager.shared.apiRequest(api: structure) { (data, error) in
                
                self.hideProgressWithGray()
                
                if error != nil{
                    
                    print(error ?? "Error")
                    return
                }
                
                if let jsonData = data{
                    
                    if let reciptData = jsonData["receipt"]{
                        
                        if let recipts = reciptData{
                            
                            if let reciptsDict = recipts as? [String:Any]{
                                
                                let listOfRecipts = reciptsDict["in_app"] as? [[String:Any]]
                                
                                self.dataSourceRecipts = [Receipt]()
                                
                                for recipt in listOfRecipts!{
                                    
                                    let reciptEntity = Receipt()
                                    reciptEntity.isTrail = recipt["is_trial_period"] as? Bool
                                    reciptEntity.productId = recipt["product_id"] as? String
                                     reciptEntity.transactionIdentifer = recipt["transaction_id"] as? String
                                    reciptEntity.purchaseDate = recipt["original_purchase_date"] as? String
                                    
                                    self.dataSourceRecipts?.append(reciptEntity)
                                }
                                
                            }
                        }
                    }
                    
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let reciptsCount = dataSourceRecipts?.count{
            
            return reciptsCount
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reciptsCell", for: indexPath)
        
        // Configure
        cell.textLabel?.text = dataSourceRecipts?[indexPath.row].transactionIdentifer
        cell.detailTextLabel?.text = dataSourceRecipts?[indexPath.row].productId
        
        return cell
    }
    
}
