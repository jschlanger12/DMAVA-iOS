//
//  ResourceModel.swift
//  Practicum
//
//  Created by dev on 4/1/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import Foundation

struct resource {
    var id: String
    var description: String
    var getURL: String
    var pdf: String
    var title: String
    
    init(id: String, description: String, getURL: String, pdf: String, title: String) {
        self.id = id
        self.description = description
        self.getURL = getURL
        self.pdf = pdf
        self.title = title
    }
}
