//
//  coursesViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 02/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**********************************************************
 This will display a segemnted control with three segments. 
 Each segment will load a pdf in a web view.
 **********************************************************/
import UIKit

class coursesViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        let myUrl : String!
        let segIndex = sender.selectedSegmentIndex
        
        switch segIndex {
        case 0:
           myUrl = "Summer2017"
        case 1:
            myUrl = "Fall2017"
        case 2:
            myUrl = "Spring17_courses"
        default:
            myUrl = "Summer2017"
        }
        let myPdf = Bundle.main.url(forResource: myUrl, withExtension: "pdf")
        let urlRequest = URLRequest(url: myPdf!)
        webView.loadRequest(urlRequest)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myPdf = Bundle.main.url(forResource: "Summer2017", withExtension: "pdf")
        let urlRequest = URLRequest(url: myPdf!)
        webView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
