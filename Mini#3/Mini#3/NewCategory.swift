//
//  NewCategory.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 18/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

protocol NewCategoryDelegate{
    func DidSubmitNewCategory(view : NewCategory, categoryName: String)
}

class NewCategory : UIView {
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var viewCenter: NewCategorySubView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!

    var delegate : NewCategoryDelegate?

    override func awakeFromNib() {
        self.frame = UIScreen.mainScreen().bounds
    }

    @IBAction func btnSave(sender: AnyObject) {
        txtField.resignFirstResponder()
        delegate?.DidSubmitNewCategory(self, categoryName: txtField.text)
        txtField.text = ""
    }

    @IBAction func btnCancel(sender: AnyObject) {
        txtField.resignFirstResponder()
        self.removeFromSuperview()
    }
}

// MARK:- Designable class
@IBDesignable
class NewCategorySubView : UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
        get{
            return layer.cornerRadius
        }
    }
}