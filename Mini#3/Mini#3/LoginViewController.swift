//
//  LoginViewController.swift
//  Mini#3
//
//  Created by Samuel Shin Kim on 22/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var validationSubview: UIView!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmTextField: UITextField!
    
    //MARK: - Interface
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationController?.navigationBarHidden = true;
        forEachUITextFieldDoBlock { (textField) -> Void in
            textField.delegate = self;
        }
    }
    
    @IBAction func toggleAccountCreation(sender: UIButton) {
        //É animado uma subview com fundo preto para esconder os campos momentaneamente.
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.validationSubview.alpha = (self.validationSubview.alpha == 0.0 ? 1.0 : 0.0);
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    //A interface é trocada para criação ou validação de conta.
                    self.confirmTextField.hidden = !self.confirmTextField.hidden;
                    self.forEachUIButtonDoBlock { (button) -> Void in
                        button.hidden = !button.hidden;
                    }
                    //A subview com fundo preto é removida.
                    self.validationSubview.alpha = (self.validationSubview.alpha == 0.0 ? 1.0 : 0.0);
                })
        }
    }
    
    @IBAction func signInAction(sender: UIButton) {
        performSegueWithIdentifier("loggedSegue", sender: self);
    }
    
    @IBAction func createAction(sender: UIButton) {
        
    }
    
    //MARK: Text Field
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: - Auxiliary functions
    
    func forEachUITextFieldDoBlock(block:(textField: UITextField) -> Void) {
        for subview in view.subviews {
            if (subview.isKindOfClass(UITextField)) {
                block(textField: subview as! UITextField);
            }
        }
    }
    
    func forEachUIButtonDoBlock(block:(button: UIButton) -> Void) {
        for subview in view.subviews {
            if (subview.isKindOfClass(UIButton)) {
                block(button: subview as! UIButton);
            }
        }
    }
}