//
//  VSOAnnotation.swift
//  
//
//  Created by dev on 12/17/18.
//

import Foundation
import MapKit
import Contacts

class VSOAnnotation: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var county: String?
    var location: String?
    var hours: String?
    var title: String?
    var phone: String?
    var fax: String?
    var email: String?
    
    init(coordinate: CLLocationCoordinate2D, county: String, location: String, hours: String, name: String, phone: String, fax: String, email: String) {
        self.coordinate = coordinate
        self.county = county
        self.location = location
        self.hours = hours
        self.title = name
        self.phone = phone
        self.fax = fax
        self.email = email
        
        super.init()
    }
    
    var subtitle: String? {
        return location
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
}
