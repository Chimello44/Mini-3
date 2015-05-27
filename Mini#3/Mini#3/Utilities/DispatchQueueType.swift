//
//  DispatchQueue.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 25/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

/**
*  Classe que fornece as filas padrões do GDC
*/
struct DispatchQueueType {

    static var Default : Int {
        return Int(QOS_CLASS_DEFAULT.value)
    }

    static var Unspecified : Int {
        return Int(QOS_CLASS_UNSPECIFIED.value)
    }

    static var UserInitiated : Int {
        return Int(QOS_CLASS_USER_INITIATED.value)
    }

    static var UserInteractive : Int {
        return Int(QOS_CLASS_USER_INTERACTIVE.value)
    }

    static var Utility : Int {
        return Int(QOS_CLASS_UTILITY.value)
    }

    static var Background : Int {
        return Int(QOS_CLASS_BACKGROUND.value)
    }

}
