//
//  NetworkChecker.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 26/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//


import SystemConfiguration

class NetworkChecker {

    class func isConnectedToNetwork() -> Bool {
        var status:Bool = false

        let url = NSURL(string: "http://parse.com")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0

        var response:NSURLResponse?

        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?

        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                status = true
            }
        }
        
        return status
    }

}