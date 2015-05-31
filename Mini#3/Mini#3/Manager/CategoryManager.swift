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
    
    let pCoreManager = ParseCoreManager.sharedInstance;
    let pLocalManager = ParseLocalManager.sharedInstance;

    private init(){
        // TODO: Resgatar os dados do parse
        self.currentUser = pLocalManager.currentUser();
        
        //O método abaixo não é utilizado porque é assíncrono.
        
//        pCoreManager.getRootCategoryOf(currentUser, block: { (rootCategory, error) -> Void in
//            if (rootCategory != nil) {
//                self.currentCategory = rootCategory;
//            } else {
//                //Alertar o usuário que sua pasta principal não foi encontrada.
//            }
//        });
        
//        self.currentUser?.rootCategory.fullSort()
    }

    var didChange : Bool = false
    /// Referência do usuário ativo.
    internal var currentUser : User!
    /// Referência do nó da árvore que o usuário está interagindo
    internal var currentCategory : Category?
    /// TODO: Implementar sistema de favoritos
//    internal var favoriteCategory : Category?

    private var categoryStack = Stack<Category>()
    
    /**
    Adiciona uma nova pasta no nó atual.

    :param: name      **String** contendo o nome da pasta
    :param: iconNamed **Não implementado**
    */
    func addCategory(name: String, iconNamed: String = "", objectId: String){
        let newcat = Category(name: name, imageIcon: iconNamed, objectId: objectId)
        self.currentCategory?.addItem(newcat)
    }

    /**
    Adiciona uma nova galeria no nó atual.

    :param: name      **String** contendo o nome da galeria
    :param: iconNamed **Não Implementado**
    */
    func addGallery(name: String, iconNamed: String = "", objectId: String){
        let newgal = Gallery(name: name, imageIcon: iconNamed, objectId: objectId)
        self.currentCategory?.addItem(newgal)
    }

    /**
    Remove uma subpasta, e todos os seus filhos

    :param: index **Int** contendo a posição do nó que será removido
    */
    func removeCategoryAtIndex(index: Int){
        self.currentCategory?.removeChildAtIndex(index)
    }

    /**
    Seleciona uma pasta para o usuário

    :param: index **Int** contendo a posição do nó selecionado
    */
    func selectCategory(index: Int){
        if self.currentCategory!.subcategory[index].type == ItemType.Category{
            self.categoryStack.push(self.currentCategory!)
            self.currentCategory = self.currentCategory!.subcategory[index] as? Category
        }
        else{
            // Implementar pra caso que seja galeria
        }
    }

    /**
    Retorna uma pasta
    */
    func back(){
        if self.categoryStack.size() > 0 {
            self.currentCategory = self.categoryStack.pop()
        }
    }

    /**
    Verifica se a view atual é a raíz

    :returns: **true** caso a pasta atual seja a raíz, **false** caso contrário.
    */
    func isRoot() -> Bool{
        return categoryStack.size() == 0
    }
}
