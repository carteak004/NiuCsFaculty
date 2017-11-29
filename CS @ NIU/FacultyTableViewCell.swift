//
//  TableViewCell.swift
//  CSFaculty_NIU
//
//  Created by Kartheek chintalapati on 30/03/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**********************************************************
 This holds the contents in the cell of faculty screen.
 **********************************************************/

import UIKit

class FacultyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel! //Head label which shows the name of the faculty and their education.
    
    @IBOutlet weak var emailLabel: UILabel! //sub head label which shows the e-mail of the faculty
    
    @IBOutlet weak var officeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
