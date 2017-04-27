//
//  TableViewController.swift
//  CSFaculty_NIU
//
//  Created by Kartheek chintalapati on 30/03/17.
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

class TableViewController: UITableViewController, UISearchBarDelegate{

    @IBOutlet var searchTableView: UITableView! //table view
    
    //Objects and variables
    var tableObject = [facultyList] () //Object of FacultyList class
    var filteredObject = [facultyList] () //Object to hold the filtered results
    
    //This is to let the controller know that I am using the same View Controller to show the search results.
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readPropertyList() //calling the function
        
        filteredObject = tableObject //initialising filteredObject object with tableObject.
        
        //MARK: SEARCH BAR RELATED
        searchController.searchResultsUpdater = self       //This will let the class be informed of any text changes in the search bar
        searchController.dimsBackgroundDuringPresentation = false   //This will not let the view controller get dim when a search is performed.
        definesPresentationContext = true   //this will make sure that the search bar will not be active in other screens
        tableView.tableHeaderView = searchController.searchBar  //This will add the search bar to table header view
        
    }
    
    //This function finds the property list, read each dictionary entries in the plist array, initialize and append the object properties in the facultyList class.
    func readPropertyList()
    {
        let path = Bundle.main.path(forResource: "facultyList", ofType: "plist")!
        let fListArray:NSArray = NSArray(contentsOfFile: path)!
        
        for dict in fListArray{
            let name = (dict as! NSDictionary)["name"] as! String
            let designation = (dict as! NSDictionary)["designation"] as! String
            let email = (dict as! NSDictionary)["email"] as! String
            let website = (dict as! NSDictionary)["website"] as! String
            let hours = (dict as! NSDictionary)["hours"] as! String
            let category = (dict as! NSDictionary)["category"] as! String
            
            tableObject.append(facultyList(name: name, designation: designation, email: email, website: website, hours: hours, category: category))
            
        }//for end
    }//func end
    
    //This function returns the filtered data
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredObject = tableObject.filter { item in
            return item.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
            return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        //This will show the search results if the search bar is active and something is typed into it or displays all the cells if no search is performed.
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredObject.count
        }
        return tableObject.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! TableViewCell
        let fList:facultyList
        
        //Determine which list to show based on search bar activity
        if searchController.isActive && searchController.searchBar.text != "" {
            fList = filteredObject[indexPath.row]
        }
        else {
            fList = tableObject[indexPath.row]
        }
        
        //place the attribs in the cell
        cell.headLabel.text = fList.name
        cell.subLabel.text = fList.email

        return cell
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        if(segue.identifier == "TableView")
        {
            let detailVC = segue.destination as! detailViewController
            
            //prepare to send the data to table view controller
            if let indexPath = self.tableView.indexPathForSelectedRow{
               
                let fList:facultyList
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
extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
