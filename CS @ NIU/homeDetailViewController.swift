//
//  detailViewController.swift
//  CSFaculty_NIU
//
//  Created by Kartheek chintalapati on 30/03/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**********************************************************
 This class will display the details about a faculty. It 
 will show the faculty's name, education, designation, 
 email, faculty hours and a website. This class also 
 allows an user to send an e-mail from the interface 
 itself. If the faculty don't have their own website, 
 a pop-up will showup saying no website.
 **********************************************************/

import UIKit
import MessageUI

class detailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var designationLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var hrsLabel: UILabel!
    
    //Head labels
    
    @IBOutlet weak var emailHead: UILabel!
    
    @IBOutlet weak var hrsHead: UILabel!
    
    //Buttons
    
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    //MARK: Prepare variables to hold data sent from the tableViewController
    var sentName:String!
    var sentDesignation:String!
    var sentEducation:String!
    var sentEmail:String!
    var sentWebsite:String!
    var sentHrs:String!
    
    //MARK: Action when e-mail button is clicked.
    @IBAction func sendEmailButtonClicked(_ sender: UIButton) {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        let toRecipients = [sentEmail]
        
        mailComposeVC.setToRecipients(toRecipients as? [String])
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeVC, animated: true, completion: nil)
        }
    }
    
    //This function will dismiss the send e-mail interface once we are done using it.
     func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load data into labels.
        nameLabel.text = sentName
        designationLabel.text = sentDesignation
        emailLabel.text = sentEmail
        
        designationLabel .sizeToFit() //This method call will automatically expand the label size based on the content
        
        hrsLabel.text = sentHrs
        hrsLabel .sizeToFit() //This method call will automatically expand the label size based on the content
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
                    if sentWebsite == "NA" //If website is NA, display a pop-up or else send data to the webVC.
                    {
                        let alertController = UIAlertController(title: "Sorry!!", message: "Website Not Available", preferredStyle: .alert)
                        
                        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                            
                            (alert: UIAlertAction!) -> Void in
                        })
                        alertController.addAction(dismissButton)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    else
                    {
                        webVC.sentURL = sentWebsite
                        webVC.sentHead = sentName
                    }
                }
            }
    }
 
    
    

}
