//
//  FacultyTableViewCell.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 06/12/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class FacultyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var inOfficeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //inOfficeLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
