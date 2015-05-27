//
//  Stack.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 19/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

/**
*  Estrutura de pilha para valores genéricos.
*/
class Stack<T>{
    private var stack : Array<T> = []
    /**
    Adiciona um elemento a pilha

    :param: a Elemento que será adicionado
    */
    func push(a : T){
        stack.append(a)
    }

    /**
    Desempilha o útimo elemento.

    :returns: Elemento que foi desempilhado ou nil, caso a pilha esteja vazia
    */
    func pop() -> T?{
        if size() > 0{
            let elem : T = stack.last!
            stack.removeLast()
            return elem
        }
        return nil
    }

    /**
    Pega o número de elementos presente na pilha

    :returns: *Int* contendo o número de elementos presente na pilha
    */
    func size() -> Int{
        return stack.count
    }

    /**
    Retorna o ultimo elemento da pilha.

    :returns: Elemento do topo da pilha ou nil, caso a pilha esteja vazia
    */
    func last() -> T?{
        if size() > 0{
            return stack.last!
        }
        return nil
    }
}