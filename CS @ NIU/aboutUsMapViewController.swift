//
//  aboutUsMapViewController.swift
//  CS @ NIU
//
//  Created by Kartheek chintalapati on 02/04/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class aboutUsMapViewController: UIViewController , CLLocationManagerDelegate{

    //MARK: Variables
    // This variable is needed for setting up the location manager
    // when the user clicks on the Locate Me button.
    var manager = CLLocationManager()
    
    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapTypeSegment: UISegmentedControl!
    
    //MARK: Actions
    // This function is called when the user selects the map type
    // on the segmented control.
    
    @IBAction func mapTypeControl(_ sender: UISegmentedControl) {
        let segIndex = sender.selectedSegmentIndex
        switch segIndex {
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = MKMapType.satellite
        case 2:
            mapView.mapType = MKMapType.hybrid
        default:
            break
        }
    }
    
    /*   This function is called when the user clicks on the Locate Me
     button.  It performs the following tasks:
     1.  Designates the location manager as the delegate.
     2.  Sets the location accuracy to be the best.
     3.  Asks the user for the permission to get his/her current location.
     4.  Once the authorizes, the location manager gets the user location
     and displays the user location on the map view.
     */

    
    @IBAction func LocateMeButton(_ sender: UIBarButtonItem) {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        //manager.showsUserLocation = true
        
    }
    
    /*  This function performs the following tasks:
     1.  Gets our user location.
     2.  Zooms in that location.
     3.  Displays the region.
     */
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //get the user location
        let userlocation:CLLocation = locations[0] as CLLocation
        
        //do not update the location change
        manager.stopUpdatingLocation()
        
        //Get the lat and long of the user location
        let location = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
        
        //Zoom in equally
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        //get the center of the region to show on the map
        let region = MKCoordinateRegion(center: location, span: span)
        
        //Display the region on the map
        mapView.setRegion(region, animated: true)
        
    }
    
    
    /* This function is called when the user clicks the "Directions" button to instruct this app to invoke the Apple's map web-application to get
     a direction from the user's current location to the Lincoln Monument,
     Washington DC.
     */
    
    @IBAction func directionsButtonClicked(_ sender: UIBarButtonItem) {
        let myURL:NSURL = URL(string: "http://maps.apple.com/maps?daddr=41.931581, -88.765053")! as NSURL
        UIApplication.shared.open(myURL as URL, options: [:], completionHandler: nil)
    }
    
    
    /*  This function is called after the app launches. Instruct the app
     to perform the following tasks:
     1.  Show a location pin drop at the Lincoln Monument, Washington DC.
     I used the latlong.net website to get the lattidue and longitude
     of the Lincoln Monument.
     2.  Clicking on the dropped pin, display the title and subtitle of
     the location.
     
     */    override func viewDidLoad() {
        super.viewDidLoad()

        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(41.931581, -88.765053)
        let objAnimation = MKPointAnnotation()
        objAnimation.coordinate = pinLocation
        objAnimation.title = "Room 460"
        objAnimation.subtitle = "Psychology-Computer Science Building"
        self.mapView.addAnnotation(objAnimation)
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
