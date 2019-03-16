//
//  FormDataModel.swift
//  Practicum
//
//  Created by dev on 3/3/19.
//  Copyright © 2019 Monmouth University. All rights reserved.
//

import Foundation

struct pdfData: Decodable {
    var status: Int
    var fieldDataList: [formData]
    
    enum CodingKeys: String, CodingKey{
        case statusCode
        case jsonObj
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .statusCode)
        print(status)
        
        fieldDataList = try container.decode([formData].self, forKey: .jsonObj)
        print(fieldDataList.count)
    }
    
}

struct formData: Decodable{
    var title: String
    var altTitle: String
    var fieldType: String
    var fieldFlags: String
    var fieldValue: String

    init(title: String, altTitle: String, fieldType: String, fieldFlags: String, fieldValue: String) {
        self.title = title
        self.altTitle = altTitle
        self.fieldType = fieldType
        self.fieldFlags = fieldFlags
        self.fieldValue = fieldValue
    }

    enum CodingKeys: String, CodingKey {
        case title
        case altTitle
        case fieldType
        case fieldFlags
        case fieldValue
    }

    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decode(String.self, forKey: .title)
        self.altTitle = try container.decode(String.self, forKey: .altTitle)
        self.fieldType = try container.decode(String.self, forKey: .fieldType)
        self.fieldFlags = try container.decode(String.self, forKey: .fieldFlags)
        self.fieldValue = try container.decode(String.self, forKey: .fieldValue)
    }
}

