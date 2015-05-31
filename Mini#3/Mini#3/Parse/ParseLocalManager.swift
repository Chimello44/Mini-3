//
//  ParseLocalManager.swift
//  Mini#3
//
//  Created by Samuel Shin Kim on 29/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

class ParseLocalManager {
    
    static let sharedInstance = ParseLocalManager();
    
    func isLogged()->Bool {
        return PFUser.currentUser() != nil
    }
    
    func logout(block : (NSError?)->Void){
        PFUser.logOutInBackgroundWithBlock(block)
    }
    
    func currentUser() -> User? {
        return PFUser.currentUser() as? User;
    }
    
//    func findRootCategoryOf(user: User, block: (rootCategory: Category?, error: NSError?) -> Void) {
//        var query = PFQuery(className: "Item");
//        query.getObjectInBackgroundWithId(user.rootCategory.objectId!, block: { (object, error) -> Void in
//            if (error == nil) {
//                var foundRoot = object as! ParseItem;
//                block(rootCategory: Category(name: foundRoot.name, type: .Category, objectId: foundRoot.objectId!), error: error);
//            } else {
//                block(rootCategory: nil, error: error);
//            }
//        });
//    }
    
    func offlineMode() {
        //TODO: Implementar modo offline
    }
    
    
    func addCategory(name: String, parent: Category, block: (objectId: String?, error: NSError?) -> Void) {
        let newCat = ParseItem(name: name, type: .Category);
        let pItem = ParseItem();
        pItem.objectId = parent.objectId;
        pItem.addObject(newCat, forKey: "subcategory");
        pItem.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if (succeeded) {
                block(objectId: newCat.objectId, error: error);
            } else {
                block(objectId: nil, error: error);
            }
        }
    }
    
}