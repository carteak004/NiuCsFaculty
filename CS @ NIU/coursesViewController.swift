//
//  coursesViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 02/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class coursesViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        let myUrl: String!
        let segIndex = sender.selectedSegmentIndex
        
        switch segIndex {
        case 0:
            myUrl = "http://www.cs.niu.edu/courses/Summer2017.pdf"
        case 1:
            myUrl = "http://www.cs.niu.edu/courses/Fall2017.pdf"
        case 2:
            myUrl = "http://www.cs.niu.edu/courses/Spring17_courses.pdf"
        default:
            myUrl = "http://www.cs.niu.edu/courses/index.shtml"
            break
        }
        let url = URL(string: myUrl!)
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
