//
//  TableViewController.swift
//  ContactCard
//
//  Created by Ruben de Haas on 19/10/15.
//  Copyright © 2015 Ruben de Haas. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class TableViewController: UITableViewController {
    
    //var persons: [Person] = []
    var cdPersons = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPersons()
    }
    
    @IBAction func AddBarBtnAction(sender: AnyObject) {
        let connection = ApiManager.sharedInstance
        connection.getUser(onCompletion)
    }

    
    func onCompletion(json:NSDictionary?,error:NSError?){
        if(error==nil){
            let jsonstring = JSON(json!)
            
            let jsonresult = jsonstring["results"]
            
            for (_,subJson):(String, JSON) in jsonresult {
                
                let p1 = Person(firstname: subJson["user"]["name"]["first"].stringValue,
                    photo: subJson["user"]["picture"]["thumbnail"].stringValue,
                    lastname: subJson["user"]["name"]["last"].stringValue)
                //persons.append(p1)
                
                addPerson(p1.firstname,lastname: p1.lastname,photoURL: p1.photo)
            }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.reloadData()
            }
            
        }else{
            print(error!.localizedDescription)
        }
    }
    
    func addPerson(firstname: String, lastname: String, photoURL: String){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("CDPerson", inManagedObjectContext:managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(firstname, forKey: "firstname")
        person.setValue(lastname, forKey: "lastname")
        person.setValue(photoURL, forKey: "thumbnailURL")
        
        do {
            try managedContext.save()
            cdPersons.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func getPersons(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "CDPerson")

        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            cdPersons = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cdPersons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personCell", forIndexPath: indexPath)
        
        // Configure the cell...
        let row = indexPath.row
        cell.textLabel?.text = cdPersons[row].valueForKey("firstname") as? String
        cell.detailTextLabel?.text = cdPersons[row].valueForKey("lastname") as? String
        
        let url = NSURL(string: cdPersons[row].valueForKey("thumbnailURL") as! String)
        let data = NSData(contentsOfURL: url!)
        cell.imageView!.image  = UIImage(data: data!)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "personDetail"{
            if let destination = segue.destinationViewController as? DetailViewController{
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    let person = cdPersons[indexPath.row]
                    destination.cdPerson = person
                }
            }
        }
        
        
        
    }
    

}
