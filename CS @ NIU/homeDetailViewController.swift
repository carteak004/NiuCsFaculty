//
//  detailViewController.swift
//  CSFaculty_NIU
//
//  Created by Kartheek chintalapati on 30/03/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var designationLabel: UILabel!
    
    @IBOutlet weak var educationLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var hrsView: UITextView!
    
    //Head labels
    
    @IBOutlet weak var emailHead: UILabel!
    
    @IBOutlet weak var hrsHead: UILabel!
    
    
    //website
    @IBOutlet weak var websiteHead: UILabel!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    //MARK: Prepare variables to hold data sent from the tableViewController
    var sentName:String!
    var sentDesignation:String!
    var sentEducation:String!
    var sentEmail:String!
    var sentWebsite:String!
    var sentHrs:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make hours text view non editable
        hrsView.isEditable = false
        
        //Load data into labels.
        nameLabel.text = sentName
        designationLabel.text = sentDesignation
        educationLabel.text = sentEducation
        
        //email null case handling. If email is not mentioned, e-mail label and text will be hidden.
        if sentEmail == "NA"{
            emailLabel.isHidden = true
            emailHead.isHidden = true
        }
        else{
            emailLabel.text = sentEmail
        }
        
        //hours null case handling. If office hours are not mentioned, hours label and text view will be hidden.
        if sentHrs != "NA"
        {
            hrsView.text = sentHrs
        }
        else{
            hrsView.isHidden = true
            hrsHead.isHidden = true
        }
        
        
        //Website null cases
        if sentWebsite != "NA"{
            websiteLabel.text = sentWebsite
        }
        else{
            websiteLabel.isHidden = true
            websiteHead.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "webView"){
            if let webVC:homeWebViewController = segue.destination as? homeWebViewController {
                webVC.sentURL = sentWebsite
                webVC.sentHead = sentName
            }
        }
    }
 
    
    

}
