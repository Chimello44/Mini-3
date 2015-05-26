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
    
    func userLogin(username: String, password: String, errorHandler: (error: NSError?) -> Void) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            errorHandler(error: error);
        }
    }
    
    func createUser(username: String, password: String, errorHandler: (error: NSError?) -> Void) {
        var newUser = PFUser();
        newUser.username = username;
        newUser.password = password;
        newUser.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
           errorHandler(error: error);
        }
    }
    
}