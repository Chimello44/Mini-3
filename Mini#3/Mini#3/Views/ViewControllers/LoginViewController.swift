//
//  LoginViewController.swift
//  Mini#3
//
//  Created by Samuel Shin Kim on 22/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var validationSubview: UIView!
    
    let pCoreManager = ParseCoreManager.sharedInstance;
    let pLocalManager = ParseLocalManager.sharedInstance;
    let catman = CategoryManager.sharedInstance;
    
    //MARK: - Interface
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
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
    
    //MARK: Login
    
    @IBAction func signInAction(sender: UIButton) {
//        let userLoginAlertController = UIAlertController(title: "Error", message: nil, preferredStyle: .Alert);
        let userLoginAlertController = UIAlertController(title: "Erro", message: nil, preferredStyle: .Alert);
        userLoginAlertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil));
        
        if (validateInput(usernameTextField.text)) {
            if (validateInput(passwordTextField.text)) {
                
                pCoreManager.userLogin(usernameTextField.text, password: passwordTextField.text, errorHandler: { (error) -> Void in
                    if (error == nil) {
                        self.catman.currentUser = self.pLocalManager.currentUser();
                        self.catman.currentCategory = nil;
                        self.dismissViewControllerAnimated(false, completion: nil);
                    } else {
                        userLoginAlertController.message = error!.localizedDescription;
                        self.presentViewController(userLoginAlertController, animated: true, completion: nil);
                    }
                })
                
            } else {
//                userLoginAlertController.message = "Your password must have between 4 and 30 alphanumerical characters";
                userLoginAlertController.message = "Sua senha deve ter entre 4 a 30 caracteres alfanuméricos";
                self.presentViewController(userLoginAlertController, animated: true, completion: nil);
            }
        } else {
//            userLoginAlertController.message = "Your username must have between 4 and 30 alphanumerical characters";
            userLoginAlertController.message = "Sua conta deve ter entre 4 a 30 caracteres alfanuméricos";
            self.presentViewController(userLoginAlertController, animated: true, completion: nil);
        }
        
    }
    
    @IBAction func createAction(sender: UIButton) {
//        let accountCreationAlertController = UIAlertController(title: "Error", message: nil, preferredStyle: .Alert);
        let accountCreationAlertController = UIAlertController(title: "Erro", message: nil, preferredStyle: .Alert);
        accountCreationAlertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil));
        
        if (validateInput(usernameTextField.text)) {
            if (validateInput(passwordTextField.text)) {
                if (passwordTextField.text == confirmTextField.text) {
                    
                    pCoreManager.createUser(usernameTextField.text, password: passwordTextField.text, errorHandler: { (error) -> () in
                        if (error == nil) {
//                            let accountCreationAlertController = UIAlertController(title: "Success", message: "Account created successfully", preferredStyle: .Alert);
                            let accountCreationAlertController = UIAlertController(title: "Sucesso", message: "Conta criada com sucesso", preferredStyle: .Alert);
                            accountCreationAlertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                                self.dismissViewControllerAnimated(false, completion: nil)
                            }));
                            self.presentViewController(accountCreationAlertController, animated: true, completion: nil);
                        } else {
                            accountCreationAlertController.message = error!.localizedDescription;
                            self.presentViewController(accountCreationAlertController, animated: true, completion: nil);
                        }
                    });
                    
                } else {
//                    accountCreationAlertController.message = "Your passwords do not match";
                    accountCreationAlertController.message = "Sua senhas não são iguais";
                    self.presentViewController(accountCreationAlertController, animated: true, completion: nil);
                }
            } else {
//                accountCreationAlertController.message = "Your password must have between 4 and 30 alphanumerical characters";
                accountCreationAlertController.message = "Sua senha deve ter entre 4 a 30 caracteres alfanuméricos";
                self.presentViewController(accountCreationAlertController, animated: true, completion: nil);
            }
        } else {
//            accountCreationAlertController.message = "Your username must have between 4 and 30 alphanumerical characters";
            accountCreationAlertController.message = "Sua conta deve ter entre 4 a 30 caracteres alfanuméricos";
            self.presentViewController(accountCreationAlertController, animated: true, completion: nil);
        }
        
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
    
    func validateInput(input: String) -> Bool {
        var error: NSError?
        var regex = NSRegularExpression(pattern: "[a-z0-9]{4,30}", options: .CaseInsensitive, error: &error);
        let matches = regex?.matchesInString(input, options: nil, range: NSMakeRange(0, count(input)));
        return matches?.count > 0 ? true : false;
    }
    
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