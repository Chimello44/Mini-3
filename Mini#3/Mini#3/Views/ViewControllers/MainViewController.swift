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
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray);

    // MARK:- DataSource Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data
    let catman = CategoryManager.sharedInstance
    let pCoreManager = ParseCoreManager.sharedInstance;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        
        self.view.addSubview(activityIndicator);
        activityIndicator.startAnimating();
        
        let rootCategoryAlertController = UIAlertController(title: "Erro", message: nil, preferredStyle: .Alert);
        rootCategoryAlertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil));
        
        if (catman.currentCategory == nil) {
            
            pCoreManager.getRootCategoryOf(catman.currentUser, block: { (rootCategory, error) -> Void in
                if (rootCategory != nil) {
                    
                    self.pCoreManager.findItemsOf(rootCategory!, block: { (items, error) -> Void in
                        if (error == nil) {
                            rootCategory!.subcategory = items!;
                            self.catman.currentCategory = rootCategory;
                            self.currentCategory = rootCategory;
                            self.title = self.currentCategory?.name
                            self.tableView.reloadData();
                            
                        } else {
                            rootCategoryAlertController.message = "Não foi possível encontrar suas pastas";
                            self.presentViewController(rootCategoryAlertController, animated: true, completion: nil);
                        }
                    });
                    
                } else {
                    rootCategoryAlertController.message = "Não foi possível encontrar sua pasta principal";
                    self.presentViewController(rootCategoryAlertController, animated: true, completion: nil);
                }
                self.activityIndicator.stopAnimating();
            });
            
        } else {
            
            currentCategory = catman.currentCategory
            
            pCoreManager.findItemsOf(currentCategory!, block: { (items, error) -> Void in
                if (error == nil) {
                    self.currentCategory!.subcategory = items!;
                    self.catman.currentCategory?.subcategory = items!;
                    self.title = self.currentCategory?.name
                    self.tableView.reloadData();
                    
                } else {
                    rootCategoryAlertController.message = "Não foi possível encontrar suas pastas";
                    self.presentViewController(rootCategoryAlertController, animated: true, completion: nil);
                }
                self.activityIndicator.stopAnimating();
            });


        }
        
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

    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {

        // Botão para renomear uma pasta/galeria
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
            self.newItemView.txtField.text = self.currentCategory?.subcategory[indexPath.row].name

            self.view.addSubview(self.newItemView)
        }

        rename.backgroundColor = UIColor.greenColor()

        // Botão para deletar uma pasta/galeria
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Deletar") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in

            let deleteAlert = UIAlertController(title: "Tem certeza que deseja apagar?", message: "", preferredStyle: UIAlertControllerStyle.Alert)

            deleteAlert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: { (a:UIAlertAction!) -> Void in

            }))

            deleteAlert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.Destructive, handler: { (a:UIAlertAction!) -> Void in
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
        return currentCategory == nil ? 0 : currentCategory!.subcategory.count
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
                    
                    self.view.addSubview(self.activityIndicator);
                    self.activityIndicator.startAnimating();
                    
                    self.pCoreManager.addCategory(name, parent: self.currentCategory!, block: { (objectId, error) -> Void in
                        if (objectId != nil) {
                            self.catman.addCategory(name, iconNamed: "", objectId: objectId!);
                            self.tableView.reloadData()
                            self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
                        } else {
                            let addCatAlertController = UIAlertController(title: "Erro", message: "Não foi possível salvar a nova pasta", preferredStyle: .Alert);
                            addCatAlertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil));
                            self.presentViewController(addCatAlertController, animated: true, completion: nil);
                        }
                        self.activityIndicator.stopAnimating();
                    });
                }
                view.removeFromSuperview()
            })

            self.newItemView.addCancelHandler({ (view : EditItemView) -> () in
                view.removeFromSuperview()
                self.navigationController?.navigationItem.rightBarButtonItem?.enabled = true
            })

            self.newItemView.title.text = "Nova Pasta"

            self.view.addSubview(self.newItemView)

        }))

        actionsheet.addAction(UIAlertAction(title: "Nova Galeria", style: UIAlertActionStyle.Default, handler: { (alert : UIAlertAction!) -> Void in

            self.newItemView.addSaveHandler({ (name : String, view: EditItemView) -> () in
                if name != ""{
                    self.catman.addGallery(name, iconNamed: "", objectId: "")
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

