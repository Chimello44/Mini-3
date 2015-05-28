//
//  FadeSegue.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 28/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class FadeSegue : UIStoryboardSegue{
    override func perform() {
        let source = self.sourceViewController.view!
        let dest = self.destinationViewController.view!


        source?.addSubview(dest!)

        dest?.frame = source!.frame
        dest?.alpha = 0

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            dest?.alpha = 1

        }) { (completed) -> Void in
            self.sourceViewController.presentViewController((self.destinationViewController as! UIViewController), animated: false, completion: nil)

            dest?.removeFromSuperview()
        }

    }

}
