//
//  InAppListViewControllerTableViewController.swift
//  InAppConsumableDemo
//
//  Created by Abhishek Ravi on 10/12/16.
//  Copyright © 2016 InnovationM. All rights reserved.
//

import UIKit
import StoreKit

class InAppListViewControllerTableViewController: UITableViewController, InAppManagerDelegate {

    //Data Source for Table View
    var dataSourceInAppProducts:[InAppProduct] = []
    
    //InApp Products
    var inAppProductsId:[String] = ["com.movingpin.tracking.consumer.iap.1day", "com.movingpin.tracking.consumer.iap.1week", "com.movingpin.tracking.consumer.iap.1month"];
    
    //InApp Manager Singleton Instance
    let inAppManager = InAppManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.intializeInApp()
        
        self.requestForProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Step 0 : InApp Setup
    func intializeInApp(){
        
        //Set Title
        self.navigationItem.title = "InApp Purchase"
        
        //Configure InApp Manager
        inAppManager.configureInAppProducts(nameOfProducts: inAppProductsId)
        inAppManager.delegate = self
    }
    
    //MARK:- Step 1 : Request
    func requestForProducts(){
        
        self.showProgressWithGray()
        
        //Request For InApp Products
        inAppManager.requestForInAppProducts()
    }
    
    //MARK: Step 2 : Handle Request Delegate
    
    func onSuccessInAppProductRequest(products:[InAppProduct]){
        
        self.hideProgressWithGray()
        
        self.dataSourceInAppProducts = products;
        self.tableView.reloadData()
    }
    
    func onFailInAppProductRequest(errorMessage:String?){
        
        self.hideProgressWithGray()
        
    
    }
    
    //MARK:- Step 3 : Purcahse
    func purchaseInApp(product:InAppProduct){
        
        self.showProgressWithGray()
        
        //Purcahse Product
        inAppManager.purchaseProduct(product: product.productInstance!)
        
    }
    
    //MARK:- Step 4 : Handle Purcahse Delegates
    func onSuccessfulPurchaseInAppProduct(transaction:InAppTransaction){
        
        self.hideProgressWithGray()
    }
    
    func onFailedPurchaseInAppProduct(errorMessage error:String?){
        
        self.hideProgressWithGray()
    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return dataSourceInAppProducts.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)

        // Configure Cell
        cell.imageView?.image = UIImage(named: "img_product")
        cell.textLabel?.text = self.dataSourceInAppProducts[indexPath.row].productTitle
        cell.detailTextLabel?.text = self.dataSourceInAppProducts[indexPath.row].productDescription

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedProduct = self.dataSourceInAppProducts[indexPath.row]
        
        self.purchaseInApp(product:selectedProduct)
        
        self.tableView.cellForRow(at: indexPath)?.isSelected  = false
        
    }
}
