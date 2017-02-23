//
//  ViewControllerExtension.swift
//  InAppConsumableDemo
//
//  Created by Abhishek Ravi on 10/12/16.
//  Copyright © 2016 InnovationM. All rights reserved.
//

import UIKit

extension UIViewController{
    
    //MARK:- Navigate
    
    //Push Navigate to ViewController
    func navigateWithPushViewController(context:UIViewController , identifier:String){
        
        let vc = context.storyboard?.instantiateViewController(withIdentifier: identifier)
        context.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //Present Navigation to View Controller
    func navigateWithPresentViewController(context:UIViewController, identifier:String){
        
        let vc = context.storyboard?.instantiateViewController(withIdentifier: identifier)
        context.present(vc!, animated: true, completion: nil)

    }
    
    //MARK: Progressbar with Gray Screen
    
    func getViewInstance()->UIView{
        
        struct Static {
            static let instance = UIView()
        }
        
        return Static.instance
    }
    
    func showProgressWithGray(){
        
        let viewFrame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let grayView = getViewInstance()
        grayView.frame = viewFrame
        grayView.layer.opacity = 0.8
        grayView.backgroundColor = UIColor.lightGray
        
        //Acitivity Indicator
        let indicator = UIActivityIndicatorView()
        indicator.center = self.view.center
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.layer.zPosition = 1
        indicator.startAnimating()
        
        //Add to GrayView
        grayView.addSubview(indicator)
        
        self.view.addSubview(grayView)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideProgressWithGray(){
        
        let indicator = UIActivityIndicatorView()
        indicator.stopAnimating()
        getViewInstance().removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }

    
}
