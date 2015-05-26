//
//  Category.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 15/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class Category : Item{

    internal var subcategory : Array<Item> = []

    init(name: String, imageIcon : String){
        super.init(name: name, imageIcon: imageIcon, type: ItemType.Category)
    }

    required init(name: String, type : ItemType){
        super.init(name: name, type: ItemType.Category)
        self.imageIcon = "categoryIcon"
    }

    override func sort(){
        self.subcategory.sort { (a: Item, b: Item) -> Bool in
            if (a.name?.caseInsensitiveCompare(b.name!) == NSComparisonResult.OrderedAscending){
                return true
            }
            else{
                return false
            }
        }
    }

    override func fullSort() {
        if subcategory.count > 0{
            dispatch_async(DispatchQueueType.Background, { () -> Void in
                self.subcategory.sort { (a: Item, b: Item) -> Bool in
                    if (a.name?.caseInsensitiveCompare(b.name!) == NSComparisonResult.OrderedAscending){
                        return true
                    }
                    else{
                        return false
                    }
                }
            })
            for item in self.subcategory{
                item.sort()
            }
        }
    }

    func removeChildAtIndex(index: Int){
        subcategory.removeAtIndex(index)
    }

    func addItem(item : Item){
        if self.subcategory.count == 0{
            self.subcategory.append(item)
        }
        else{
            let i = binarySearch(item, range: (0 ,self.subcategory.count))
            self.subcategory.insert(item, atIndex: i)
        }
    }

    func binarySearch(item : Item,  range : (start:Int, end:Int)) -> Int{
        if range.start >= range.end{
            return range.start
        }
        else{
            let i : Int = range.start+((range.end-range.start)/2)
            
            if (item.name.caseInsensitiveCompare(self.subcategory[i].name) == NSComparisonResult.OrderedDescending){
                return binarySearch(item, range:(i+1, range.end))
            }
            else{
                return binarySearch(item, range:(range.start, i))
            }
        }
    }
}