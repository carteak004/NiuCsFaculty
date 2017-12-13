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
 properties when the search controller is active. This class 
 shows a label on the faculty cell if they have a plan.
 **********************************************************/


import UIKit
import CoreData

class FacultyViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    //Objects and variables
    var tableObject = [FacultyList] () //Object of FacultyList class
    var filteredObject = [FacultyList] () //Object to hold the filtered results
    var inactiveQueue:DispatchQueue!
    
    var listArray = [[String]]()
    var hoursArray = [[String]]()
    
    // We will use this variable to help us display data from
    // CoreData using FetchedResultsController.
    var controller: NSFetchedResultsController<Favorite>!
    
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
            self.readFaculty()
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
    

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    //MARK : - User defined functions
    
    //This function returns the filtered data
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredObject = tableObject.filter { item in
            return item.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    

    //This function reads faculty details
    func readFaculty()
    {
        let apiUrl = URL(string: "http://students.cs.niu.edu/~z1788719/niucs/faculty.php") // create URL Variable
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
                            if let name = item["name"] as? String, let designation = item["designation"] as? String, let email = item["email"] as? String, let website = item["website"] as? String
                            {
                                /*self.tableObject.append(FacultyList(name: name, designation: designation, email: email, website: website))*/
                                self.listArray.append([name,designation,email,website])
                                //print("faculty: \(name)")
                            }

                        }
                        //print("Faculty: \(self.listArray.count)")
                        //print("goinf out for with i=\(i)")
                        self.readFacultyHours()
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
    
    
    //this function reads the faculty hours
    func readFacultyHours()
    {
        let apiUrl = URL(string: "http://students.cs.niu.edu/~z1788719/niucs/facultyHours.php") // create URL Variable
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
                            if let facultyName = item["facultyName"] as? String, let room = item["room"] as? String, let officeHours = item["officeHours"] as? String
                            {
                                self.hoursArray.append([facultyName,room,officeHours])
                                //print(room)
                            }
                            
                        }
                        //print("Hours: \(self.hoursArray.count)")
                        //print("goinf out for with i=\(i)")
                        self.facultyDetailsList()
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
    
    
    //This function combines office hours with faculty.
    func facultyDetailsList()
    {
        for faculty in listArray
        {
            var justHoursArray = [[String]]()
            
            for hours in hoursArray
            {
                if faculty[0] == hours[0]
                {
                    justHoursArray.append([hours[1],hours[2]])
                }
            }
            self.tableObject.append(FacultyList(name: faculty[0], designation: faculty[1], email: faculty[2], website: faculty[3], hours: justHoursArray))
            //print(faculty[0])
        }
        //print("combined \(self.tableObject.count)")
        self.tableObject.sort
            {
                return $0.name < $1.name
        }
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating() //stop animating
            self.tableView.isHidden = false        //reveal the table view
            self.tableView.reloadData()            //reload the table view
        }
    }
    
    func facultyStatus(hours:[[String]]) -> Bool
    {
        var status = false
        
        for hour in hours
        {
            let officeDay = hour[1].components(separatedBy: " : ")
            //print(officeDay)
            
            let date = Date()
            //print(date)
            let calendar = Calendar.current
            let day = calendar.component(.weekday, from: date)
            //print(day)
            
            var givenDay = 0
            
            switch officeDay[0]
            {
            case "M":
                givenDay = 2
            case "T":
                givenDay = 3
            case "W":
                givenDay = 4
            case "Th":
                givenDay = 5
            case "F":
                givenDay = 6
            default:
                break;
            }
            
            if givenDay == day
            {
                //print("Match for current")
                let time = officeDay[1]
                //print(time)
                
                let Time:[String] = time.components(separatedBy: " - ")
                //print(Time)
                let fromTime = calendar.date(
                    bySettingHour: Int(Time[0].components(separatedBy: ":").first!)!+6,
                    minute: Int(Time[0].components(separatedBy: ":").last!)!,
                    second: 0,
                    of: date)!
                
                let toTime = calendar.date(
                    bySettingHour: Int(Time[1].components(separatedBy: ":").first!)!+6,
                    minute: Int(Time[1].components(separatedBy: ":").last!)!,
                    second: 0,
                    of: date)!
                
                if date >= fromTime &&
                    date <= toTime
                {
                    //print("The time is between 8:00 and 16:30")
                    status = status || true
                }
                else
                {
                    //print("Time doesn't match")
                    status = status || false
                }
                
            }
            else
            {
                //print("Doesn't Match for current")
                status = status || false
            }
        }
        
        return status
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
        
        if facultyStatus(hours: fList.hours)
        {
            cell.inOfficeLabel.isHidden = false
        }
        else
        {
            cell.inOfficeLabel.isHidden = true
        }
        return cell
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TableView")
        {
            let detailVC = segue.destination as! FacultyDetailViewController
            
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
                //print(fList.hours)
                
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
