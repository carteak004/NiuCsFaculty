//
//  aboutUsViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 02/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/**********************************************************
 This will display the department's address, phone number 
 and a map view that pin points the department's location 
 on a map. When clicked on the phone number, user can call 
 directly from the app itself.
 **********************************************************/
import UIKit
import MapKit
import CoreLocation

class aboutUsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func callButtonClicked(_ sender: UIButton) {
        let myURL:NSURL = URL(string: "tel://18157530378")! as NSURL
        UIApplication.shared.open(myURL as URL, options: [:], completionHandler: nil)
        
        // Display the simple alert since we cannot test the above
        // code on the simulator
       /* let alertController = UIAlertController(title: "Calling..", message: "1(815)753-0378", preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        alertController.addAction(dismissButton)
        self.present(alertController, animated: true, completion: nil)
 */
    }
    
    
    /*  This function is called after the app launches. Instruct the app
     to perform the following tasks:
     1.  Show a zoomed in location pin drop at CS Dept.
     I used the latlong.net website to get the lattidue and longitude
     of CS dept.
     2.  Clicking on the dropped pin, display the title and subtitle of
     the location.
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.931581, -88.765053) //lat and long of department.
        let objAnimation = MKPointAnnotation()
        objAnimation.coordinate = pinLocation
        objAnimation.title = "Room 460" //title of the pin head
        objAnimation.subtitle = "Psychology-Computer Science Building" //subtitle of the map head
        self.mapView.addAnnotation(objAnimation)
        
        // Zoom in equally
        let span = MKCoordinateSpanMake(0.5, 0.5)
        
        // Get the center of the region to show on the map
        let region = MKCoordinateRegion(center: pinLocation, span: span)
        
        // Display the region on the map
        mapView.setRegion(region, animated: true)

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
