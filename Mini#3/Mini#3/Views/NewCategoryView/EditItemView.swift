//
//  NewCategory.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 18/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class EditItemView : UIView {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var viewCenter: NewCategorySubView!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    var saveHandler : ((String, EditItemView) -> ())?
    var cancelHandler : ((EditItemView) -> ())?

    override func awakeFromNib() {
        self.frame = UIScreen.mainScreen().bounds
    }

    func addSaveHandler(handler : (String, EditItemView) -> ()){
        self.saveHandler = { handler($0, $1) }
    }

    func addCancelHandler(handler : (EditItemView) -> ()){
        self.cancelHandler = { handler($0) }
    }

    @IBAction func btnSave(sender: AnyObject) {
        txtField.resignFirstResponder()
        if self.saveHandler != nil {
            saveHandler!(txtField.text, self)
        }
        else{
            NSException(name: "InvalidCallException", reason: "Save Handler not set", userInfo: nil).raise()
        }
        txtField.text = ""
    }

    @IBAction func btnCancel(sender: AnyObject) {
        txtField.resignFirstResponder()
        if self.cancelButton != nil {
            cancelHandler!(self)
        }
        else{
            NSException(name: "InvalidCallException", reason: "Cancel Handler not set", userInfo: nil).raise()
        }
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