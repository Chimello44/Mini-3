//
//  FirstViewController.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 14/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewCategoryDelegate {

    private var newCategoryView : NewCategoryView!
    private var selectedIndex : NSIndexPath?


    @IBOutlet weak var tableView: UITableView!

    var currentCategory : Category?


    // MARK:- DataSource Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data
    let catman = CategoryManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        newCategoryView = NSBundle.mainBundle().loadNibNamed("NewCategoryView", owner: self, options: nil).first as! NewCategoryView
        newCategoryView.delegate = self

        currentCategory = catman.currentCategory

        self.title = currentCategory?.name

        self.tableView.setEditing(false, animated: false)
    }

    override func viewWillDisappear(animated: Bool) {
        if self.navigationController?.viewControllers.filter({$0 as! NSObject == self}).count == 0{
            catman.back()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK:- NewCategoryDelegte
    func DidSubmitNewCategory(view : NewCategoryView, categoryName: String) {
        if categoryName != ""{
            catman.addCategory(categoryName, iconNamed: "")
        }
        view.removeFromSuperview()
        tableView.reloadData()
        self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
    }

    func DidCancelNewCategory(view: NewCategoryView) {
        
        self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
    }

    // MARK:- Table View Delegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selected = currentCategory?.subcategory[indexPath.row] as! Category

        if selected.type == ItemType.Category{
            self.catman.selectCategory(indexPath.row)
            let nextView: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("categoryViewController") as! UIViewController
            self.navigationController?.pushViewController(nextView, animated: true)
        }

        else if selected.type == ItemType.Gallery{
            performSegueWithIdentifier("gallerySegue", sender: indexPath)
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let rename = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Renomear") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in

            println("ROAR")
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

        return [rename,delete]
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
        self.view.addSubview(newCategoryView)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let index = sender as! NSIndexPath
        if segue.identifier == "categorySegue"{
            segue.perform()
        }
        else if segue.identifier == "gallerySegue"{
            segue.perform()
        }
    }

}

