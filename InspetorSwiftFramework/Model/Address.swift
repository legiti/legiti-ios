//
//  Address.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class Address: AbstractModel, InspetorSerialize {
    
    //MARK: Properties
    var street: String
    var number: String?
    var zipCode: String
    var city: String
    var state: String
    var country: String
    var latitude: String?
    var longitude: String?
    
    //MARK: init
    init(street: String, zipCode: String, city: String, state: String, country: String) {
        self.street = street
        self.zipCode = zipCode
        self.city = city
        self.state = state
        self.country = country
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["address_street"] = self.encodeData(stringToEncode: self.street)
        dict["address_number"] = self.encodeData(stringToEncode: self.number)
        dict["address_zip_code"] = self.encodeData(stringToEncode: self.zipCode)
        dict["address_city"]  = self.encodeData(stringToEncode: self.city)
        dict["address_state"] = self.encodeData(stringToEncode: self.state)
        dict["address_country"] = self.encodeData(stringToEncode: self.country)
        dict["address_latitude"] = self.encodeData(stringToEncode: self.latitude)
        dict["address_longitude"] = self.encodeData(stringToEncode: self.longitude)
    
        return dict
    }
    
    
    
}
