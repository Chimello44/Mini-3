//
//  ParseCoreManager.swift
//  Mini#3
//
//  Created by Samuel Shin Kim on 22/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

class ParseCoreManager {
    
    static let sharedInstance = ParseCoreManager();
    
    func createUser(username: String, password: String) {
        var newUser = PFUser();
        newUser.username = username;
        newUser.password = password;
        newUser.signUpInBackgroundWithBlock { (success, error) -> Void in
            
            println(error!.localizedDescription)
            
        }
        
        
    }
    
}