//
//  HotlineModel.swift
//  Practicum
//
//  Created by dev on 3/18/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import Foundation

struct hotline {
    var id: String
    var description: String
    var phone: String
    var title: String
    var webURL: String
    
    init(id: String, description: String, phone: String, title: String, webURL: String){
        self.id = id
        self.description = description
        self.phone = phone
        self.title = title
        self.webURL = webURL
    }
}

