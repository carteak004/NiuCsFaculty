//
//  homeWebViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 03/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**********************************************************
 This will display the web address sent to it by the detailVC
 **********************************************************/
import UIKit

class homeWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var sentURL:String!
    var sentHead: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: sentURL)
        
        let urlRequest = URLRequest(url: myURL!)    //create a urlrequest
        webView.loadRequest(urlRequest) //load the web view
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
