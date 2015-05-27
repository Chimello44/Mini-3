//
//  GalleryViewController.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 26/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

let reuseIdentifier = "PhotoCell"

class GalleryViewController : UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    var album = Array<UIImage>()

    var galman = GalleryManager.sharedInstance

    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func btnGallery(sender: AnyObject) {
        
        self.navigationController?.navigationItem.rightBarButtonItem?.enabled = false
        
        let actionSheet = UIAlertController(title: "O que gostaria de fazer?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title:"Tirar uma Foto", style:UIAlertActionStyle.Default, handler:{ action in
            self.btnCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title:"Escolher uma Foto", style:UIAlertActionStyle.Default, handler:{ action in
            self.btnLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel, handler:nil))
        presentViewController(actionSheet, animated:true, completion:nil)
    }
    
    
    
    
    func btnCamera(){
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){

            var picker : UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
        }else{
            //camera not available
            var alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)

        }
    }
    func btnLibrary(){
        var picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = GalleryManager.sharedInstance.currentGallery!.name
        self.album = GalleryManager.sharedInstance.currentGallery!.imgData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //UICollectionViewDataSource

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album.count
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "viewLargePhoto"{
            let indexPath = self.collectionView.indexPathForCell(sender as! UICollectionViewCell)
            var detailVC = segue.destinationViewController as! ViewPhoto
            detailVC.img = album[indexPath!.row]
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell: PhotoCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell

        cell.img.image = album[indexPath.row]

        return cell
    }


    //MARK: - Delegates

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(chosenImage.description)
        album.append(chosenImage)
        collectionView.reloadData()

        dismissViewControllerAnimated(true, completion: nil)

    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}
