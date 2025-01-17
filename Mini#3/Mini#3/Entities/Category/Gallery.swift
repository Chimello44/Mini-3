//
//  Gallery.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 15/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class Gallery : Item {

    internal var imgData : Array<UIImage> = []
    
    init(name: String, imageIcon : String, objectId: String){
        super.init(name: name, imageIcon: imageIcon, type: ItemType.Gallery, objectId: objectId)
    }

    required init(name: String, type : ItemType, objectId: String){
        super.init(name: name, type: ItemType.Gallery, objectId: objectId)
        self.imageIcon = "galleryIcon"
    }

//    override func sort(){
//        dispatch_async(Int(QOS_CLASS_BACKGROUND.value), { () -> Void in
//            self.imgData.sort { $0 < $1 }
//        })
//    }
//
//    func addItem(item : String){
//        self.imgData.append(item)
//        self.imgData.sort { $0 < $1 }
//    }
}