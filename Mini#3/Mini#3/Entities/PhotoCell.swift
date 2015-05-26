//
//  PhotoCell.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 26/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class PhotoCell : UICollectionViewCell  {

    @IBOutlet weak var img: UIImageView!

    func setPhotoCellImage(PhotoCellImg: UIImage){
        self.img.image = PhotoCellImg

    }

}
