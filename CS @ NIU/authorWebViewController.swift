//
//  authorWebViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 07/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/**********************************************************
 This will load the personal webpage based on the segue or 
 address sent.
 **********************************************************/

import UIKit

class authorWebViewController: UIViewController {

    var myPath: String!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a path to the index.html "data" file bundled under the "html" folder
        let path = Bundle.main.path(forResource: myPath, ofType: "html")!
        let data:NSData = NSData(contentsOfFile:path)!
        let html = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        
        // Load the webView outlet with the content of the index.html file
        webView.loadHTMLString(html! as String, baseURL: Bundle.main.bundleURL)
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
