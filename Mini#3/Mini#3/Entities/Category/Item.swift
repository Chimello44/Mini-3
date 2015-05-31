//
//  Item.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 19/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

/**
Enumerador contendo os tipos de item.

- Category
- Gallery
*/
enum ItemType: String {
    case Category = "Category"
    case Gallery = "Gallery"
}

/**
*  Tipo genério da estrutura de dados
*/
class Item {
    /// Nome do nó
    internal var name : String!
    /// **Não Implementado**
    internal var imageIcon : String!
    /// Tipo do nó
    internal var type : ItemType!
    /// identificador único do objeto no parse
    internal var objectId: String!
    
    static func parseClassName() -> String {
        return "Item";
    }

    init(name: String, imageIcon : String, type : ItemType, objectId: String){
        self.name = name
        self.imageIcon = imageIcon
        self.type = type
        self.objectId = objectId
    }

    required init(name: String, type : ItemType, objectId: String){
        self.name = name
        self.type = type
        self.objectId = objectId
    }

    func sort(){
        preconditionFailure("precisar ser implementado na classe filha!")
    }

    func fullSort(){
        preconditionFailure("precisar ser implementado na classe filha!")
    }
    
}