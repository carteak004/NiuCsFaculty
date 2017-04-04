//
//  facultyList.swift
//  CSFaculty_NIU
//
//  Created by Kartheek chintalapati on 30/03/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class facultyList: NSObject {
    
    var name: String!
    var designation: String!
    var education: String!
    var email: String!
    var website: String!
    var hours: String!
    var category: String!
    
    init(name: String, designation: String, education: String, email: String, website: String, hours: String, category: String) {
        self.name = name
        self.designation = designation
        self.education = education
        self.email = email
        self.website = website
        self.hours = hours
        self.category = category
    }
    

}
