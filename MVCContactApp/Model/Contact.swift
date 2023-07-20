//
//  Contact.swift
//  MVCContactApp
//
//  Created by Narasimha on 17/07/23.
//

import UIKit

struct ContactFields {
    let firstname: String
    let lastname: String
    let image: String
}

struct Contact{
    func parseJSONFromFile() {
        guard let jsonURL = Bundle.main.url(forResource: "JsonFile", withExtension: "json"),
              let jsonData = try? Data(contentsOf: jsonURL),
              let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: String]] else {
            return
        }
        for item in jsonArray {
            if let titleJson = item["firstname"],
               let titledJson = item["lastname"],
               let imageJson = item["image"]{
                contacts.append(ContactFields(firstname: titleJson, lastname: titledJson , image: imageJson))
            }
            else{
                print("Iteams does not meet the required format")
            }
        }
    }
}





