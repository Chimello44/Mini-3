//
//  Stack.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 19/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

class Stack<T>{
    var stack : Array<T> = []

    func push(a : T){
        stack.append(a)
    }

    func pop() -> T?{
        if size() > 0{
            let elem : T = stack.last!
            stack.removeLast()
            return elem
        }
        return nil
    }

    func size() -> Int{
        return stack.count
    }

    func last() -> T?{
        if size() > 0{
            return stack.last!
        }
        return nil
    }
}