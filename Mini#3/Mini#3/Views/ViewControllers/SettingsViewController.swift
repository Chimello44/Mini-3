//
//  SettingsViewController.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 14/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController{
    
    let pLocalManager = ParseLocalManager.sharedInstance;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutAction(sender: UIButton) {
        pLocalManager.logout { (error) -> Void in
            if (error == nil) {
                let userLogoutAlertController = UIAlertController(title: "Sucesso", message: "Você se desconectou com sucesso", preferredStyle: .Alert);
                userLogoutAlertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil);
                }));
                self.presentViewController(userLogoutAlertController, animated: true, completion: nil);
            } else {
                let userLogoutAlertController = UIAlertController(title: "Erro", message: error?.localizedDescription, preferredStyle: .Alert);
                userLogoutAlertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil));
                self.presentViewController(userLogoutAlertController, animated: true, completion: nil);
            }
        }
    }

}

