//
//  ApiManager.swift
//  ContactCard
//
//  Created by Ruben de Haas on 19/10/15.
//  Copyright © 2015 Ruben de Haas. All rights reserved.
//

import Foundation

class ApiManager: NSObject{
    
    static let sharedInstance = ApiManager()
    
    var apiUrl: String?
    
    override init() {
        apiUrl = "https://randomuser.me/api/?results=10"
    }
    
    func getUser(onCompletion: (NSDictionary?,NSError?)-> Void){
        let url = NSURL(string: apiUrl!)
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {(data,response,error)->Void in
            
            if(error != nil){
                onCompletion(nil, error)
            }
            
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                onCompletion(json,nil)
            }catch{
                onCompletion(nil,error as NSError)
            }
        })
        task.resume()
        
    }
}