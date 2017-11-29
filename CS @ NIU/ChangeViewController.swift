//
//  ChangeViewController.swift
//  CS @ NIU
//
//  Created by ta on 11/28/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        let userEmail = nameField.text!
        let userPwd = fromField.text!
        
        /*let myUrl = URL(fileURLWithPath: "http://students.cs.niu.edu/~z1788719/niucs/userRegister.php") */
        
        //var request = URLRequest(url: myUrl)
        
        let apiUrl = URL(string: "http://students.cs.niu.edu/~z1788719/niucs/userRegister.php") // create URL Variable
        var request = URLRequest(url: apiUrl!)

        
        request.httpMethod = "POST";
        
        let postString = "email=\(userEmail)&password=\(userPwd)"
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        //submit a request to fetch data
        let task = URLSession.shared.dataTask(with: request)
        {
            (data,response,error) in
            //if there is an error, print it onto console and don't continue
            if error != nil {
                print(error!)
                return
            }
            
            //if there is no error, fetch json content
            if let content = data
            {
                do
                {
                    let jsonObject = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? AnyObject
                    
                    if let parseJson = jsonObject
                    {
                        var resultValue = parseJson["status"] as? String
                        print("result: \(resultValue)")
                        
                        var isUserRegistered  = false
                        if resultValue == "Success"
                        {
                            isUserRegistered = true
                        }
                        
                        var messageToDisplay:String = parseJson["message"] as! String
                        if(!isUserRegistered)
                        {
                            messageToDisplay = parseJson["message"] as! String!
                        }
                        
                        var myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: .default){ action in
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                        myAlert.addAction(okAction)
                        self.present(myAlert, animated: true, completion: nil)
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
