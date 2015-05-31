//
//  ParseItem.swift
//  Mini#3
//
//  Created by Samuel Shin Kim on 30/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

class ParseItem: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var imageIcon: String
    @NSManaged var type: String
    @NSManaged var subcategory: [ParseItem]
    @NSManaged var imgData: [PFFile]
    
    static func parseClassName() -> String {
        return "Item";
    }
    
    override init() {
        super.init();
    }
    
    init(name: String, type: ItemType) {
        super.init();
        self.name = name;
        self.type = type.rawValue;
    }
    
    init(name: String, imageIcon: String, type: ItemType) {
        super.init();
        self.name = name;
        self.imageIcon = imageIcon;
        self.type = type.rawValue;
    }
    
    init(name: String, type: ItemType, subcategory: [Item]) {
        super.init();
        self.name = name;
        self.type = type.rawValue;
        self.subcategory = [];
        for item in subcategory {
            if (item.type == ItemType.Category) {
                var newCat = ParseItem(name: item.name, type: item.type, subcategory: (item as! Category).subcategory);
                self.subcategory.append(newCat);
            } else {
                var newGal = ParseItem(name: item.name, type: item.type, imgData: (item as! Gallery).imgData);
                self.subcategory.append(newGal);
            }
        }
    }
    
    init(name: String, type: ItemType, imgData: [UIImage]) {
        super.init();
        self.name = name;
        self.type = type.rawValue;
        self.imgData = [];
        for img in imgData {
            var newImg = PFFile(data: UIImagePNGRepresentation(img));
            self.imgData.append(newImg);
        }
    }
    
}