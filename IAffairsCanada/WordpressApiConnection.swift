//
//  WordpressApiConnection.swift
//  IAffairsCanada
//
//  Created by Kyle Bernstein on 3/7/15.
//  Copyright (c) 2015 IAffairsCanada. All rights reserved.
//

import Foundation

class WordpressApiConnection  {
    
    static let sharedInstance = WordpressApiConnection()
    
    func doRequest(url: String, method: String, callback: (String, Bool) -> Void) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = method
        
        var session = NSURLSession.sharedSession()
        
        var error: NSError? = nil
        var response: NSURLResponse? = nil
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if error != nil {
                callback(error.localizedDescription, true)
            } else {
                var responseData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                callback(responseData as String, false)
            }
            
        })
        
        task.resume()
    }
}