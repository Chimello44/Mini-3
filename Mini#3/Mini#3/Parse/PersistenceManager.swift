//
//  PersistenceManager.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 28/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

enum PersistenceType {
    case Local, Remote
}

class PersistenceManager{
    let parseCore = ParseCoreManager.sharedInstance

    func isLogged()->Bool {
        return PFUser.currentUser() != nil
    }

    func logout(block : (NSError?)->Void){
        PFUser.logOutInBackgroundWithBlock(block)
    }

}