//
//  ViewPhoto.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 26/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class ViewPhoto: UIViewController {

    var img: UIImage?


    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func btnCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        let galman = GalleryManager.sharedInstance
        imgView.image = img
    }
}
