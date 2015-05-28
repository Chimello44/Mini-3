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
    @IBAction func btnGallery(sender: AnyObject) {
        self.navigationController?.navigationItem.rightBarButtonItem?.enabled = false
        
        let actionSheet = UIAlertController(title: "O que gostaria de fazer?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title:"Deletar Foto", style:UIAlertActionStyle.Default, handler:{ action in
            self.deletePhoto()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title:"Compartilhar Foto", style:UIAlertActionStyle.Default, handler:{ action in
            
            println("Share!!!!! >.< )))) kawai senpai")
            
        }))
        
        actionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel, handler:nil))
        presentViewController(actionSheet, animated:true, completion:nil)
    }
    
    func deletePhoto(){
        
        let alert = UIAlertController(title: "Excluir a foto?", message: "Voce tem certeza que gostaria de deletar a foto?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: {(alertAction) in
            
            //Deletar a foto
        }))
        
        alert.addAction(UIAlertAction(title: "Não", style: .Cancel, handler: {(alertAction) in
//            alert.dismissModalViewControllerAnimated(true)
            
        }))
        
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        let galman = GalleryManager.sharedInstance
        imgView.image = img
    }
}
