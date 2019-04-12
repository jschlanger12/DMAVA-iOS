//
//  MapViewController.swift
//  Practicum
//
//  Created by dev on 12/17/18.
//  Copyright © 2018 Monmouth University. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    let regionRadius: CLLocationDistance = 30000
    var annotations:[VSOAnnotation] = []
    
    var VSOList: [VSO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        getVSO()
        
        locManager.requestWhenInUseAuthorization()
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
        }
        
        let initialLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        centerMapOnLocation(location: initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func getVSO(){
        let db = Firestore.firestore()
        
        db.collection("vsos").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
 
                    let currentVSO = VSO.init(address: document.data()["address"] as! String, address2: document.data()["address2"] as! String, city: document.data()["city"] as! String, contact: document.data()["contact"] as! String, email: document.data()["email"] as! String, fax: document.data()["fax"] as! String, hours: document.data()["hours"] as! String, id: document.data()["id"] as! String, latitude: document.data()["latitude"] as! String, longitude: document.data()["longitude"] as! String, phone: document.data()["phone"] as! String, state: document.data()["state"] as! String, title: document.data()["title"] as! String, zip: document.data()["zip"] as! String)

                    self.VSOList.append(currentVSO)
                    
                    var combinedAddress = ""
                    
                    switch currentVSO.address2{
                    case "":
                        combinedAddress = currentVSO.address + " " + currentVSO.city + " " + currentVSO.state + " " + currentVSO.zip
                    default:
                        combinedAddress = currentVSO.address + " " + currentVSO.address2 + " " + currentVSO.city + " " + currentVSO.state + " " + currentVSO.zip
                    }
                    
                    let lat: Double = Double(currentVSO.latitude)!
                    let long: Double = Double(currentVSO.longitude)!
                    
                    let VSOCoord = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
                    
                    self.createAnnotation(coordinate: VSOCoord, county: currentVSO.title, location: combinedAddress, hours: currentVSO.hours, name: currentVSO.contact, phone: currentVSO.phone, fax: currentVSO.fax, email: currentVSO.email)
                }
                
                for annotation in self.annotations{
                    self.mapView.addAnnotation(annotation)
                }
            }
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

extension MapViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? VSOAnnotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! VSOAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
