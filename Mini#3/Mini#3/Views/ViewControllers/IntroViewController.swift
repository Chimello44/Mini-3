//
//  IntroViewController.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 28/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import Foundation

class IntroViewController : UIViewController {
    override func viewDidLoad() {

    }

    override func viewWillAppear(animated: Bool) {
        self.view.alpha = 1
    }

    override func viewDidAppear(animated: Bool) {
        let persistence = PersistenceManager()
        if persistence.isLogged(){
            performSegueWithIdentifier("MainSegue", sender: nil)
        }
        else{
            performSegueWithIdentifier("LoginSegue", sender: nil)
        }
    }
}