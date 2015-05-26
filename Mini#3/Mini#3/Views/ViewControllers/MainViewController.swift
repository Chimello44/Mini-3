//
//  MainViewController.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 14/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    private var newItemView : EditItemView!
    private var selectedIndex : NSIndexPath?


    @IBOutlet weak var tableView: UITableView!

    var currentCategory : Category?


    // MARK:- DataSource Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data
    let catman = CategoryManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()


        currentCategory = catman.currentCategory

        self.title = currentCategory?.name

        self.tableView.setEditing(false, animated: false)


        // New Item Setup
        newItemView = NSBundle.mainBundle().loadNibNamed("EditItemView", owner: self, options: nil).first as! EditItemView

    }

    override func viewWillDisappear(animated: Bool) {
        if self.navigationController?.viewControllers.filter({$0 as! NSObject == self}).count == 0{
            catman.back()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK:- Table View Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selected : Item = currentCategory!.subcategory[indexPath.row]

        if selected.type == ItemType.Category{
            self.catman.selectCategory(indexPath.row)
            let nextView: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("categoryViewController") as! UIViewController
            self.navigationController?.pushViewController(nextView, animated: true)
        }

        else if selected.type == ItemType.Gallery{
//            performSegueWithIdentifier("gallerySegue", sender: indexPath)
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let rename = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Renomear") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in

            self.newItemView.addSaveHandler({ (name : String, view: EditItemView) -> () in
                if name != ""{
                    self.currentCategory?.subcategory[indexPath.row].name = name
                    self.currentCategory?.sort()
                }
                view.removeFromSuperview()
                self.tableView.reloadData()
                self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
            })

            self.newItemView.addCancelHandler({ (view : EditItemView) -> () in
                view.removeFromSuperview()
                self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
            })

            self.newItemView.title.text = "Editar nome"

            self.view.addSubview(self.newItemView)
        }

        rename.backgroundColor = UIColor.greenColor()

        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Deletar") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in

            let deleteAlert = UIAlertController(title: "Apagar?", message: "", preferredStyle: UIAlertControllerStyle.Alert)

            deleteAlert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { (a:UIAlertAction!) -> Void in

            }))

            deleteAlert.addAction(UIAlertAction(title: "FUS ROH DAH", style: UIAlertActionStyle.Destructive, handler: { (a:UIAlertAction!) -> Void in
                self.catman.removeCategoryAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)

            }))

            self.presentViewController(deleteAlert, animated: true, completion: nil)

        }

        delete.backgroundColor = UIColor.redColor()

        return [delete,rename]
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    // MARK:- Data Source delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentCategory!.subcategory.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: UITableViewCell?

        if self.currentCategory?.subcategory[indexPath.row].type == ItemType.Category{
            cell = self.tableView.dequeueReusableCellWithIdentifier("categoryCell")! as? UITableViewCell

        }
        else {
            cell = self.tableView.dequeueReusableCellWithIdentifier("galleryCell")! as? UITableViewCell
        }

        cell!.textLabel!.text = self.currentCategory?.subcategory[indexPath.row].name

        return cell!
    }

    // MARK:- Buttons Action
    @IBAction func btnAddEntry(sender: AnyObject) {
        self.navigationController?.navigationItem.rightBarButtonItem?.enabled = false
        let actionsheet = UIAlertController(title: "O que vai adicionar?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)

        actionsheet.addAction(UIAlertAction(title: "Nova Pasta", style: UIAlertActionStyle.Default, handler: { (alert : UIAlertAction!) -> Void in

            self.newItemView.addSaveHandler({ (name : String, view: EditItemView) -> () in
                if name != ""{
                    self.catman.addCategory(name, iconNamed: "")
                }
                view.removeFromSuperview()
                self.tableView.reloadData()
                self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
            })

            self.newItemView.addCancelHandler({ (view : EditItemView) -> () in
                view.removeFromSuperview()
                self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
            })

            self.newItemView.title.text = "Nova Categoria"

            self.view.addSubview(self.newItemView)

        }))

        actionsheet.addAction(UIAlertAction(title: "Nova Galeria", style: UIAlertActionStyle.Default, handler: { (alert : UIAlertAction!) -> Void in

            self.newItemView.addSaveHandler({ (name : String, view: EditItemView) -> () in
                if name != ""{
                    self.catman.addGallery(name, iconNamed: "")
                }
                view.removeFromSuperview()
                self.tableView.reloadData()
                self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
            })

            self.newItemView.addCancelHandler({ (view : EditItemView) -> () in
                view.removeFromSuperview()
                self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
            })

            self.newItemView.title.text = "Nova Galeria"

            self.view.addSubview(self.newItemView)

        }))

        actionsheet.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { (alert) -> Void in
            actionsheet.dismissViewControllerAnimated(true, completion: nil)
        }))

        self.presentViewController(actionsheet, animated: true, completion: nil)
    }


    // MARK:- Navigation (Segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "categorySegue"{
            segue.perform()
        }
        else if segue.identifier == "gallerySegue"{

            let indexPath : NSIndexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)!
            
            GalleryManager.sharedInstance.currentGallery = self.currentCategory!.subcategory[indexPath.row] as? Gallery

        }
    }

}

