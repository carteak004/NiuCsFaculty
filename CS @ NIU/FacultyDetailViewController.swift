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

class FacultyDetailViewController: UIViewController, MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var designationLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    //Head labels
    
    @IBOutlet weak var emailHead: UILabel!
    
    @IBOutlet weak var hrsHead: UILabel!
    
    //Buttons
    
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    //MARK: Prepare variables to hold data sent from the tableViewController
    var sentName:String!
    var sentDesignation:String!
    var sentEmail:String!
    var sentWebsite:String!
    var sentHrs:[[String]]!
    
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
        designationLabel.sizeToFit() //This method call will automatically expand the label size based on the content
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table View Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentHrs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        
        cell.textLabel?.text = "\(sentHrs[indexPath.row][0])   \(sentHrs[indexPath.row][1])"
        
        if facultyStatus(hours:sentHrs[indexPath.row])
        {
            cell.textLabel?.textColor = UIColor.green
        }
        else
        {
            cell.textLabel?.textColor = UIColor.black
        }
        return cell
    }
    
    func facultyStatus(hours:[String]) -> Bool
    {

        let officeDay = hours[1].components(separatedBy: " : ")
        //print(officeDay)
        
        let date = Date()
        //print(date)
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: date)
        //print(day)
        
        var givenDay = 0
        
        switch officeDay[0]
        {
        case "M":
            givenDay = 2
        case "T":
            givenDay = 3
        case "W":
            givenDay = 4
        case "Th":
            givenDay = 5
        case "F":
            givenDay = 6
        default:
            break;
        }
        
        if givenDay == day
        {
            //print("Match for current")
            let time = officeDay[1]
            //print(time)
            
            let Time:[String] = time.components(separatedBy: " - ")
            //print(Time)
            let fromTime = calendar.date(
                bySettingHour: Int(Time[0].components(separatedBy: ":").first!)!+6,
                minute: Int(Time[0].components(separatedBy: ":").last!)!,
                second: 0,
                of: date)!
            
            let toTime = calendar.date(
                bySettingHour: Int(Time[1].components(separatedBy: ":").first!)!+6,
                minute: Int(Time[1].components(separatedBy: ":").last!)!,
                second: 0,
                of: date)!
            
            if date >= fromTime &&
                date <= toTime
            {
                //print("The time is between 8:00 and 16:30")
                return true
            }
            else
            {
                //print("Time doesn't match")
                return false
            }
            
        }
        else
        {
            //print("Doesn't Match for current")
            return false
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
            if(segue.identifier == "webView"){
                
                if let webVC:FacultyWebViewController = segue.destination as? FacultyWebViewController
                {
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
