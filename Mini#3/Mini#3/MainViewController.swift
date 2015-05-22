//
//  FirstViewController.swift
//  Mini#3
//
//  Created by Vitor Kawai Sala on 14/05/15.
//  Copyright (c) 2015 Los caras com escritório legal. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewCategoryDelegate {

    private var newCategoryView : NewCategory!
    private var selectedIndex : NSIndexPath?


    @IBOutlet weak var tableView: UITableView!

    var currentCategory : Category?


    // MARK:- DataSource Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data
    let catman = CategoryManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        newCategoryView = NSBundle.mainBundle().loadNibNamed("NewCategory", owner: self, options: nil).first as! NewCategory
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
    func DidSubmitNewCategory(view : NewCategory, categoryName: String) {
        if categoryName != ""{
            catman.addCategory(categoryName, iconNamed: "")
        }
        view.removeFromSuperview()
        tableView.reloadData()
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

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        self.catman.removeCategoryAtIndex(indexPath.row)

        self.tableView.reloadData()
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

