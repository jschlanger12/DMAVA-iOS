//
//  VSOAnnotation.swift
//  
//
//  Created by dev on 12/17/18.
//

import Foundation
import MapKit

class VSOAnnotation: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var county: String?
    var location: String?
    var hours: String?
    var name: String?
    var phone: String?
    var fax: String?
    var email: String?
    
    init(coordinate: CLLocationCoordinate2D, county: String, location: String, hours: String, name: String, phone: String, fax: String, email: String) {
        self.coordinate = coordinate
        self.county = county
        self.location = location
        self.hours = hours
        self.name = name
        self.phone = phone
        self.fax = fax
        self.email = email
    }
    
}
