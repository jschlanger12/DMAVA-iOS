//
//  VSOModel.swift
//  Practicum
//
//  Created by dev on 12/17/18.
//  Copyright © 2018 Monmouth University. All rights reserved.
//

import Foundation

struct VSO{
    
    var address: String
    var address2: String
    var city: String
    var contact: String
    var email: String
    var fax: String
    var hours: String
    var id: String
    var latitude: String
    var longitude: String
    var phone: String
    var state: String
    var title: String
    var zip: String
    
    init(address: String, address2: String, city: String, contact: String, email: String, fax: String, hours: String, id: String, latitude: String, longitude: String, phone: String, state: String,title: String, zip: String){
        self.address = address
        self.address2 = address2
        self.city = city
        self.contact = contact
        self.email = email
        self.fax = fax
        self.hours = hours
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.state = state
        self.title = title
        self.zip = zip
    }
}
