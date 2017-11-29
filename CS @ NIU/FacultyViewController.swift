//
//  homeViewController.swift
//  CS @ NIU
//
//  Created by ta on 11/28/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**********************************************************
 This class fetches the data from facultyList plist and
 displays that as a table in the table view controller.
 It also sends data to Detail view controller about the
 faculty. The search bar is also defined in this class
 to search for faculty. In the whole class, there will be
 a if class which will return filteredObject or its
 properties when the search controller is active.
 **********************************************************/


import UIKit

class FacultyViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    //Objects and variables
    var tableObject = [FacultyList] () //Object of FacultyList class
    var filteredObject = [FacultyList] () //Object to hold the filtered results
    var inactiveQueue:DispatchQueue!
    
    //This is to let the controller know that I am using the same View Controller to show the search results.
    let searchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        activityIndicator.hidesWhenStopped = true
        
        super.viewDidLoad()
        
        tableView.isHidden = true
        activityIndicator.startAnimating()
        
        if let queue = inactiveQueue
        {
            queue.activate()
        }
        
        let queueX = DispatchQueue(label: "edu.niu.cs.queueX")
        queueX.sync {
            readPropertyList() //calling the function
        }

        
        
        filteredObject = tableObject //initialising filteredObject object with tableObject.
        
        //MARK: SEARCH BAR RELATED
        searchController.searchResultsUpdater = self       //This will let the class be informed of any text changes in the search bar
        searchController.dimsBackgroundDuringPresentation = false   //This will not let the view controller get dim when a search is performed.
        definesPresentationContext = true   //this will make sure that the search bar will not be active in other screens
        tableView.tableHeaderView = searchController.searchBar  //This will add the search bar to table header view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK : - User defined functions
    
    //This function returns the filtered data
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredObject = tableObject.filter { item in
            return item.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    

    func readPropertyList()
    {
        let apiUrl = URL(string: "http://students.cs.niu.edu/~z1788719/niucs/service.php") // create URL Variable
        let urlRequest = URLRequest(url: apiUrl!)
        
        //submit a request to fetch data
        let task = URLSession.shared.dataTask(with: urlRequest)
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
                    let jsonObject = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    //fetch required data
                    if let facultyJson = jsonObject["result"] as? [[String:AnyObject]] {
                        //var i=0
                        for item in facultyJson
                        {
                            if let name = item["name"] as? String, let designation = item["designation"] as? String, let email = item["email"] as? String, let website = item["website"] as? String, let hours = item["hours"] as? String
                            {
                                self.tableObject.append(FacultyList(name: name, designation: designation, email: email, website: website, hours: hours))
                                //print(name)
                            }

                        }
                        //print("goinf out for with i=\(i)")
                    }
                    
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating() //stop animating
                        self.tableView.isHidden = false        //reveal the table view
                        self.tableView.reloadData()            //reload the table view
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
    
    //MARK: Delegate Methods
    
    //This function dismisses the keyboard when tapped outside the field
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //This function dismisses the keyboard when the user presses the return key
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchController.resignFirstResponder()
        
        return true
    }
    
    // MARK: - Table view data source
    
   func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //This will show the search results if the search bar is active and something is typed into it or displays all the cells if no search is performed.
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredObject.count
        }
        return tableObject.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "FacultyCell", for: indexPath) as! FacultyTableViewCell
        
        let fList:FacultyList
        
        //Determine which list to show based on search bar activity
        if searchController.isActive && searchController.searchBar.text != "" {
            fList = filteredObject[indexPath.row]
        }
        else {
            fList = tableObject[indexPath.row]
        }
        
        //place the attribs in the cell
        cell.nameLabel.text = fList.name
        cell.emailLabel.text = fList.email
        cell.officeLabel.text = fList.hours
        
        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TableView")
        {
            let detailVC = segue.destination as! detailViewController
            
            //prepare to send the data to table view controller
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                let fList:FacultyList
                if searchController.isActive && searchController.searchBar.text != "" {
                    fList = filteredObject[indexPath.row]
                }
                else
                {
                    fList = tableObject[indexPath.row]
                }
                
                detailVC.sentName = fList.name
                detailVC.sentDesignation = fList.designation
                detailVC.sentEmail = fList.email
                detailVC.sentWebsite = fList.website
                detailVC.sentHrs = fList.hours
                
            }
        }
    }

}




// This class extension allows the table view controller to respond to search bar by implementing UISearchResultsUpdating.
extension FacultyViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
