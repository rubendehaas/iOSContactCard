//
//  TableViewController.swift
//  ContactCard
//
//  Created by Ruben de Haas on 19/10/15.
//  Copyright © 2015 Ruben de Haas. All rights reserved.
//

import UIKit
import SwiftJSON

class TableViewController: UITableViewController {
    
    var persons: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateTableView()
        
        let connection = ApiManager.sharedInstance
        connection.getUser(onCompletion)
        
    }
    
    func onCompletion(json:NSDictionary?,error:NSError?){
        if(error==nil){
            let bla = JSON(json)
            
            
            print(bla)
        }else{
            print(error!.localizedDescription)
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
        return persons.count
    }
    
    func populateTableView(){
        let p1 = Person(firstname: "Henk", photo: UIImage(named: "hoofd")!, lastname: "Muts")
        let p2 = Person(firstname: "Peter", photo: UIImage(named: "hoofd")!, lastname: "Muts")
        let p3 = Person(firstname: "Frans", photo: UIImage(named: "hoofd")!, lastname: "Muts")
        persons.append(p1)
        persons.append(p2)
        persons.append(p3)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personCell", forIndexPath: indexPath)

        // Configure the cell...
        let row = indexPath.row
        cell.textLabel?.text = persons[row].firstname
        cell.detailTextLabel?.text = persons[row].firstname
        cell.imageView?.image = persons[row].photo

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
                    let person = persons[indexPath.row]
                    destination.person = person
                }
            }
        }
        
        
        
    }
    

}
