//
//  programsTableViewCell.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 01/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/**********************************************************
 This holds the contents in the cell of programs screen.
 **********************************************************/
import UIKit

class programsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.sizeToFit() //this function wraps the label text to multiple lines
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
