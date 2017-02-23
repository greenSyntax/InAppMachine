//
//  WebServiceManager.swift
//  InAppConsumableDemo
//
//  Created by Abhishek Ravi on 21/02/17.
//  Copyright © 2017 InnovationM. All rights reserved.
//

import Foundation

struct ApiStructure{
    
    var url:URL
    var type:String
    var body:[String:Any]?
    
    init(url:URL, withType type:String, withBody body:[String:Any]?) {
        
        self.url = url
        self.type = type
        self.body = body ?? [:]
    }
}

class WebServiceManager{
    
    static let shared = WebServiceManager()
    
    //MARK:- Get Request
    func apiRequest(api:ApiStructure, withResponse callback:@escaping (AnyObject?, Error?)->Void){
        
        let session = URLSession.shared
        var request = URLRequest(url: api.url)
        
        if let body = api.body{
            
            request.httpMethod = api.type
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        //Data Request
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil{
                
                //onFailure
                callback(nil, error)
                return
            }
            
            guard let responseData = data else{
                
                print("There is something error with your response.")
                return
            }
            
            let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: [])
            
            //onSuccess
            callback(jsonData as AnyObject, nil)
        }
        
        task.resume()
    }
}
