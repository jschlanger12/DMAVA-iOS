//
//  MapViewController.swift
//  Practicum
//
//  Created by dev on 12/17/18.
//  Copyright © 2018 Monmouth University. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    let regionRadius: CLLocationDistance = 30000
    let vsoModel = VSOModel.SharedInstance
    var annotations:[VSOAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        
        locManager.requestWhenInUseAuthorization()
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
        }
        
        let initialLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        centerMapOnLocation(location: initialLocation)
        
        populateAnnotations();
        
        for annotation in annotations{
            mapView.addAnnotation(annotation)
        }

        // Do any additional setup after loading the view.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func populateAnnotations(){
        for VSO in vsoModel.VSO{
            print(VSO)
            
            let lat = (VSO["lat"]! as NSString).doubleValue
            let long = (VSO["long"]! as NSString).doubleValue
            
            let newCoords = CLLocationCoordinate2D(latitude: lat, longitude: long)
            createAnnotation(coordinate: newCoords, county: VSO["county"] as! String, location: VSO["location"] as! String, hours: VSO["hours"] as! String, name: VSO["name"] as! String, phone: VSO["phone"] as! String, fax: VSO["fax"] as! String, email: VSO["email"] as! String)
        }
    }
    
    func createAnnotation(coordinate loc: CLLocationCoordinate2D, county: String, location: String, hours: String, name: String, phone: String, fax: String, email: String){
        
        let newAnnotation = VSOAnnotation(coordinate: loc, county: county, location: location, hours: hours, name: name, phone: phone, fax: fax, email: email)
        
        annotations.append(newAnnotation)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
