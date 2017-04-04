//
//  TableViewController.swift
//  CSFaculty_NIU
//
//  Created by Kartheek chintalapati on 30/03/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

//MARK: Collapsible Menu Struct
struct Portion {
    var name: String!
    var items: [facultyList]!
    var collapsed: Bool!
    
    init(name: String, items: [facultyList], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

class TableViewController: UITableViewController, UISearchBarDelegate, CollapsibleTableViewHeaderDelegate {

    @IBOutlet var searchTableView: UITableView!
    
    //Objects and variables
    var tableObject = [facultyList] () //Object of FacultyList class
    var filteredObject = [facultyList] () //Object to hold the filtered results
    
    //This is to let the controller know that I am using the same View Controller to show the search results.
    let searchController = UISearchController(searchResultsController: nil)
    
    //Collapsible Menu related
    var portions = [Portion] ()
    var facultyPortion = [facultyList] ()
    var adminPortion = [facultyList] ()
    var retiredPortion = [facultyList] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        readPropertyList()
        
        //MARK: SEARCH BAR RELATED
        searchController.searchResultsUpdater = self       //This will let the class be informed of any text changes in the search bar
        searchController.dimsBackgroundDuringPresentation = false   //This will not let the view controller get dim when a search is performed.
        definesPresentationContext = true   //this will make sure that the search bar will not be active in other screens
        tableView.tableHeaderView = searchController.searchBar  //This will add the search bar to table header view
        
        //MARK: Collapsible Menu related
        //Initialize the portions array
        portions = [
            Portion(name: "Department Administration", items: adminPortion),
            Portion(name: "Emeriti and Retired Faculty", items: retiredPortion),
            Portion(name: "Faculty", items: facultyPortion)
        ]
        
        
    }
    
    //This function finds the property list, read each dictionary entries in the plist array, initialize and append the object properties in the facultyList class.
    func readPropertyList()
    {
        let path = Bundle.main.path(forResource: "facultyList", ofType: "plist")!
        let fListArray:NSArray = NSArray(contentsOfFile: path)!
        
        for dict in fListArray{
            let name = (dict as! NSDictionary)["name"] as! String
            let designation = (dict as! NSDictionary)["designation"] as! String
            let education = (dict as! NSDictionary)["education"]  as! String
            let email = (dict as! NSDictionary)["email"] as! String
            let website = (dict as! NSDictionary)["website"] as! String
            let hours = (dict as! NSDictionary)["hours"] as! String
            let category = (dict as! NSDictionary)["category"] as! String
            
            tableObject.append(facultyList(name: name, designation: designation, education: education, email: email, website: website, hours: hours, category: category))
            
            switch category {
            case "retired":
                retiredPortion.append(facultyList(name: name, designation: designation, education: education, email: email, website: website, hours: hours, category: category))
            case "faculty, admin":
                adminPortion.append(facultyList(name: name, designation: designation, education: education, email: email, website: website, hours: hours, category: category))
                facultyPortion.append(facultyList(name: name, designation: designation, education: education, email: email, website: website, hours: hours, category: category))
            default:
                facultyPortion.append(facultyList(name: name, designation: designation, education: education, email: email, website: website, hours: hours, category: category))
                
            }//switch end
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
        if searchController.isActive && searchController.searchBar.text != "" {
            return 1
        }
        return portions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        //This will show the search results if the search bar is active and something is typed into it or displays all the cells if no search is performed.
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredObject.count
        }
        //return tableObject.count
        return portions[section].items.count
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
            //fList = tableObject[indexPath.row]
            fList = portions[indexPath.section].items[indexPath.row]
        }
        
        //place the attribs in the cell
        cell.headLabel.text = fList.name
        cell.subLabel.text = fList.email
        cell.hrsLabel.text = fList.hours

        return cell
    }
 
    // fucntion to determine the height of a cell for collapsible menu
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return portions[indexPath.section].collapsed! ? 0 : 144.0
    }
    
    //Header for collapsible menu
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = portions[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(portions[section].collapsed)
        
        header.section = section
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    //Section Header Delegate
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !portions[section].collapsed
        
        //Toggle Collapse
        portions[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        //Adjust the height of the rows inside the section
        tableView.beginUpdates()
        for i in 0 ..< portions[section].items.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
                let fList:facultyList = tableObject[indexPath.row]
                
                detailVC.navigationItem.title = fList.name
                detailVC.sentName = fList.name
                detailVC.sentDesignation = fList.designation
                detailVC.sentEducation = fList.education
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
