//
//  User.swift
//  Mini#3
//
//  Created by Samuel Shin Kim on 15/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

class User {

    var username: String!
//    var phoneNumber: String
    
    /**
    *  é a categoria raíz de cada um dos usuários (Pasta inicial)
    */
    lazy var rootCategory : Category = {
        return Category(name: "Principal",type: ItemType.Category)
        }()
    
    /**
    *  Categorias e/ou galerias marcadas como favoritos para um determinado usuário
    *  Este será exibido só na table inicial.
    */
    lazy var favorite : Category = {
        Category(name: "Principal",type: ItemType.Category)
        }()
    
}