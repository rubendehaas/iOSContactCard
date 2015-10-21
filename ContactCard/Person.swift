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
    var photo: String
    
    init(firstname: String, photo: String, lastname: String) {
        self.firstname = firstname
        self.photo = photo
        self.lastname = lastname
    }
}