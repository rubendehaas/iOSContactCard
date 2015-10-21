//
//  ViewController.swift
//  ContactCard
//
//  Created by Ruben de Haas on 19/10/15.
//  Copyright © 2015 Ruben de Haas. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    @IBOutlet weak var imgFace: UIImageView!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    var person: Person!
    var cdPerson = NSManagedObject!()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: cdPerson.valueForKey("thumbnailURL") as! String)
        let data = NSData(contentsOfURL: url!)
        imgFace.image  = UIImage(data: data!)
        
 
        firstnameLabel.text = cdPerson.valueForKey("firstname") as? String
        lastnameLabel.text = cdPerson.valueForKey("lastname") as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

