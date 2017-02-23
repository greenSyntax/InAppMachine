//
//  HomeViewController.swift
//  InAppConsumableDemo
//
//  Created by Abhishek Ravi on 10/12/16.
//  Copyright © 2016 InnovationM. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func buttonRequestForInAppProductsClicked(_ sender: AnyObject) {
        
        //Navigate to InAppListVC
        self.navigateWithPushViewController(context: self, identifier: "InAppListViewController")
    }
   
    @IBAction func buttonGetPastPurchase_Clicked(_ sender: Any) {
        
        //Get InApp Recipts
        self.navigateWithPushViewController(context: self, identifier: "reciptViewController")
        
    }

}
