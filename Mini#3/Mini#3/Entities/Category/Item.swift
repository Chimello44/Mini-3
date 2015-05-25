//
//  Item.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 19/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

enum ItemType{
    case Category, Gallery
}

class Item{
    internal var name : String!
    internal var imageIcon : String!
    internal var type : ItemType!

    init(name: String, imageIcon : String, type : ItemType){
        self.name = name
        self.imageIcon = imageIcon
        self.type = type
    }

    required init(name: String, type : ItemType){
        self.name = name
        self.type = type
    }

    func sort(){
        preconditionFailure("precisar ser implementado na classe filha!")
    }
}