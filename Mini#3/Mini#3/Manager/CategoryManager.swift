//
//  CategoryManager.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 18/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation



class CategoryManager{
    static let sharedInstance = CategoryManager()

    private init(){
        self.currentUser = User()
        self.currentCategory = self.currentUser?.rootCategory
        self.favoriteCategory = self.currentUser?.favorite
        self.currentUser?.rootCategory.sort()
    }

    var didChange : Bool = false

    internal var currentUser : User? 
    internal var currentCategory : Category?
    internal var favoriteCategory : Category?

    private var categoryStack = Stack<Category>()

    func addCategory(name: String, iconNamed: String){
        let newcat = Category(name: name, imageIcon: "lalala")
        self.currentCategory?.addItem(newcat)
    }

    func addFavorite(item : Item){
        self.currentUser?.favorite.addItem(item)
    }

    func removeCategoryAtIndex(index: Int){
        self.currentCategory?.removeChildAtIndex(index)
    }

    func removeFavoriteAtIndex(index: Int){
        self.currentUser?.favorite.removeChildAtIndex(index)
    }

    func selectCategory(index: Int){
        if self.currentCategory!.subcategory[index].type == ItemType.Category{
            self.categoryStack.push(self.currentCategory!)
            self.currentCategory = self.currentCategory!.subcategory[index] as? Category
        }
        else{
            // Implementar pra caso que seja galeria
        }
    }

    func back(){
        if self.categoryStack.size() > 0 {
            self.currentCategory = self.categoryStack.pop()
        }
    }
}
