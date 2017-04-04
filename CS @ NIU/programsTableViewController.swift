//
//  programsTableViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 01/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class programsTableViewController: UITableViewController {

    var progObject = [programs] () //instance of programs class
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        readPropertyList()
    }
    
    //This function finds the property list, read each dictionary entries (properties)
    // in the plist arrray, and append initalize the object protperies in the programs class.
    
    func readPropertyList()
    {
        let path = Bundle.main.path(forResource: "programs", ofType: "plist")!
        let progArray:NSArray = NSArray(contentsOfFile: path)!
        
        for dict in progArray{
            let name = (dict as! NSDictionary)["name"] as! String
            let website = (dict as! NSDictionary)["website"] as! String
            
            progObject.append(programs(name: name, website: website))
        }
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
        // #warning Incomplete implementation, return the number of rows
        return progObject.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let progList:programs = progObject[indexPath.row]
        let cell:programsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "programsCELL") as! programsTableViewCell
        
        //place the attribs in the cell
        cell.nameLabel.text = progList.name

        return cell
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
        
        if (segue.identifier == "programsSegue")
        {
            let detailVC = segue.destination as! programsDetailViewController
            
            //prepare to send the data to detail view controller
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let progList:programs = progObject[indexPath.row]
                
                detailVC.navigationItem.title = progList.name
                detailVC.sentURL = progList.website
            }
        }
    }
    

}
