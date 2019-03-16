//
//  VSOModel.swift
//  Practicum
//
//  Created by dev on 12/17/18.
//  Copyright © 2018 Monmouth University. All rights reserved.
//

import Foundation

typealias VSODictionary = [String: String]

class VSOModel {
    static let SharedInstance = VSOModel();
    var VSO:[VSODictionary] = [[:]]
    
    init()
    {
        readJsonFile()
        print("testing init")
    }
    
    func readJsonFile () {
        if let path = Bundle.main.path(forResource: "VSO", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    print("hey")
                    if let jsonResult: [VSODictionary] = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [VSODictionary] {
                        print("testing")
                        VSO = jsonResult
                    }
                    
                } catch {}
            } catch {}
        }
    }
}

//struct VSO : Decodable{
//    let county: String
//    let location: String
//    let hours: String
//    let name: String
//    let phone: String
//    let fax: String
//    let email: String
//
//    var dictionary: VSODictionary{
//        return [
//            "county": county,
//            "location": location,
//            "hours": hours,
//            "name": name,
//            "phone": phone,
//            "fax": fax,
//            "email": email
//        ]
//    }
//}
//
//struct Response: Decodable {
//    let VSOList: [VSO]
//}
//
//class VSOModel{
//    static let SharedInstance = VSOModel();
//    var VSOArray: [VSO] = []
//
//    private init(){
//        parseJSON()
//    }
//
//    func parseJSON() {
//        if let path = Bundle.main.path(forResource: "VSO", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONDecoder().decode(Response.self, from: data)
//
//                VSOArray = jsonResult.VSOList
//
//            } catch {
//                print("error")
//                print(error)
//            }
//        }
//
//    }
//
//    var VSODictArray: [VSODictionary] = []
//
//    func populateVSODict(){
//        for VSO in VSOArray{
//            let aVSODict = VSO.dictionary
//            VSODictArray.append(aVSODict)
//        }
//    }
//}
