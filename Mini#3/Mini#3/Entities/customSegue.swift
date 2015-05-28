//
//  customSegue.swift
//  Mini#3
//
//  Created by Hugo Luiz Chimello on 5/28/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class customSegue : UIStoryboardSegue{
    
    override func perform() {
        var sourceViewController: GalleryViewController = self.sourceViewController as! GalleryViewController
        var destinationViewController: ViewPhoto = self.destinationViewController as! ViewPhoto
        
        sourceViewController.view.addSubview(destinationViewController.view)
        
        destinationViewController.view.transform = CGAffineTransformMakeScale(0.05,0.05)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            
            destinationViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
            })  {(finished) -> Void in
                
                destinationViewController.view.removeFromSuperview()
                sourceViewController.navigationController?.pushViewController(destinationViewController, animated: false)
               
    }
    
    
}
}
