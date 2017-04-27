//
//  facultyList.swift
//  CSFaculty_NIU
//
//  Created by Kartheek chintalapati on 30/03/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**********************************************************
 This is the class declaration of faculty. This class 
 contains field to contain the details of faculty like 
 name, designation, email, website, hours and category.
 **********************************************************/
import UIKit

class facultyList: NSObject {
    
    var name: String!
    var designation: String!
    var email: String!
    var website: String!
    var hours: String!
    var category: String!
    
    init(name: String, designation: String, email: String, website: String, hours: String, category: String) {
        self.name = name
        self.designation = designation
        self.email = email
        self.website = website
        self.hours = hours
        self.category = category
    }
    

}
