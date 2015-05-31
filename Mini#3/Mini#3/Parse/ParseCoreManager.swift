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
        var newUser = User();
        newUser.username = username;
        newUser.password = password;
        newUser.name = "";
        newUser.rootCategory = ParseItem(name: "Principal", type: .Category);
        newUser.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            errorHandler(error: error);
        }
    }
    
    func addCategory(name: String, parent: Category, block: (objectId: String?, error: NSError?) -> Void) {
        let newCat = ParseItem(name: name, type: .Category);
        
        var query = PFQuery(className: "Item");
        query.getObjectInBackgroundWithId(parent.objectId, block: { (object, error) -> Void in
            if let foundCat = object as? ParseItem {
                foundCat.addObject(newCat, forKey: "subcategory");
                foundCat.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                    if (succeeded) {
                        block(objectId: newCat.objectId, error: error);
                    } else {
                        block(objectId: nil, error: error)
                    }
                }
            } else {
                block(objectId: nil, error: error);
            }
        });
        
//        let pItem = ParseItem();
//        pItem.objectId = parent.objectId;
//        pItem.addObject(newCat, forKey: "subcategory");
//        pItem.saveInBackgroundWithBlock { (succeeded, error) -> Void in
//            if (succeeded) {
//                block(objectId: newCat.objectId, error: error);
//            } else {
//                block(objectId: nil, error: error);
//            }
//        }
    }
    //
    //    func addGallery(name: String, parent: Category, errorHandler: (error: NSError?) -> Void) -> String {
    //        var pItem = ParseItem(name: name, type: .Gallery);
    //        pItem.saveInBackgroundWithBlock { (succeeded, error) -> Void in
    //            errorHandler(error: error);
    //        }
    //        return pItem.objectId;
    //
    //
    //        query.getObjectInBackgroundWithId(self.threadImageIds[objectIDkey]) {
    //            (object, error) -> Void in
    //            if error != nil {
    //                println(error)
    //            } else {
    //                if let object = object {
    //                    object["viewed"] = true as Bool
    //                }
    //                object!.saveInBackground()
    //            }
    //        }
    //    }
    
    func getRootCategoryOf(user: User, block: (rootCategory: Category?, error: NSError?) -> Void) {
        var query = PFQuery(className: "Item");
        query.getObjectInBackgroundWithId(user.rootCategory.objectId!, block: { (object, error) -> Void in
            if let foundRoot = object as? ParseItem {
                block(rootCategory: Category(name: foundRoot.name, type: .Category, objectId: foundRoot.objectId!), error: error);
            } else {
                var newRoot = ParseItem(name: "Principal", type: .Category);
                newRoot.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                    if (succeeded) {
                        block(rootCategory: Category(name: newRoot.name, type: .Category, objectId: newRoot.objectId!), error: error);
                    } else {
                        block(rootCategory: nil, error: error);
                    }
                });
            }
        });
    }
    
    func findItemsOf(cat: Category, block: (items: [Item]?, error: NSError?) -> Void) {
        var querry = PFQuery(className: "Item");
        querry.includeKey("subcategory");
        querry.getObjectInBackgroundWithId(cat.objectId, block: { (object, error) -> Void in
            if let foundCat = object as? ParseItem {
                var items: [Item] = [];
                for subcategory in foundCat.subcategory {
                    if (subcategory.type == "Category") {
                        items.append(Category(name: subcategory.name, type: .Category, objectId: subcategory.objectId!));
                    } else {
                        items.append(Gallery(name: subcategory.name, type: .Gallery, objectId: subcategory.objectId!));
                    }
                }
                block(items: items, error: error);
            } else {
                block(items: nil, error: error);
            }
        });
    }
    
    func test() {
        //        let catman = CategoryManager.sharedInstance;
        //
        //        var gal = Gallery(name: "yo", type: .Gallery);
        //        var parseGal = ParseItem(name: gal.name, type: gal.type, imgData: gal.imgData);
        //
        //
        //        var cat = Category(name: "ae", type: .Category);
        //        var cat2 = Category(name: "ae2", type: .Category);
        //        cat.addItem(cat2);
        //        cat.addItem(gal);
        //        var parseCat = ParseItem(name: cat.name, type: cat.type, subcategory: cat.subcategory);
        //
        //        parseCat.saveInBackgroundWithBlock { (succeeded, error) -> Void in
        //            if (succeeded) {
        //                println("yes");
        //            } else {
        //                println(error?.localizedDescription);
        //            }
        //        }
        
        println("wololo");
        
        //        var cat = Category(name: "ae", type: .Category);
        //        cat.objectId = "khwCe7bknn";
        //        findItemsOf(cat, block: { (items, error) -> Void in
        //            println("search done");
        //        });
        //        println("done");
    }
    
}