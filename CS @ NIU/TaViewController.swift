//
//  TaViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 02/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**********************************************************
 This will display the PDF in a web view.
 **********************************************************/
import UIKit

class TaViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let myURL = URL(string: "http://www.cs.niu.edu/faculty/SP17GTA_Hours.pdf")
        let pdf = Bundle.main.url(forResource: "FA17GTAAssigments", withExtension: "pdf") //load pdf 
        
        let urlRequest = URLRequest(url: pdf!)
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
