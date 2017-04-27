//
//  aboutAppViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 07/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/**********************************************************
 This page shows a label which gives the description of the 
 app and two buttons one for each author to displayh their 
 personal webpage. This page also shows the version of the 
 app.
 **********************************************************/

import UIKit

class aboutAppViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        descLabel.sizeToFit() //This method call will automatically expand the label size based on the content
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
        let authorVC = segue.destination as! authorWebViewController
        
        if(segue.identifier == "kartheek")
        {
            //prepare to send the data to table view controller
            authorVC.myPath = "/kartheekhtml/index"
            authorVC.navigationItem.title = "Kartheek Chintalapati"
        }
        
        if(segue.identifier == "lenin")
        {
            //prepare to send the data to table view controller
            authorVC.myPath = "/leninhtml/index"
            authorVC.navigationItem.title = "Bhargav Lenin Pallam"
        }
    }




}
