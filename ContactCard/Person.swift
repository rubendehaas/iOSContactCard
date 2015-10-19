//
//  Person.swift
//  ContactCard
//
//  Created by Ruben de Haas on 19/10/15.
//  Copyright © 2015 Ruben de Haas. All rights reserved.
//

import Foundation
import UIKit

class Person{
    var firstname: String
    var lastname: String
    var photo: UIImage
    
    init(firstname: String, photo: UIImage, lastname: String) {
        self.firstname = firstname
        self.photo = photo
        self.lastname = lastname
    }
}