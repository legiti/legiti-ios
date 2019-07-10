//
//  Account.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 07/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation


class Account: AbstractModel, InspetorSerialize {

    //MARK: Actions
    enum accountActions: String {
        case create = "account_create"
        case update = "account_update"
        case delete = "account_delete"
    }
    
    //MARK: PROPERTIES
    var id: String
    var name: String?
    var email: String
    var document: String?
    var phone_number: String?
    var address: Address?
    var billingAddress: Address?
    var timestamp: Int
    
    //MARK: init
    init(id: String, email: String, timestamp: Int) {
        self.id = id
        self.email = email
        self.timestamp = timestamp
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any]()
        
        dict["account_id"] = self.encodeData(stringToEncode: self.id)
        dict["account_name"] = self.encodeData(stringToEncode: self.name)
        dict["account_email"] = self.encodeData(stringToEncode: self.email)
        dict["account_document"]  = self.encodeData(stringToEncode: self.document)
        dict["account_address"] = self.encodeObject(objectToEncode: self.address)
        dict["account_billing_address"] = self.encodeObject(objectToEncode: self.billingAddress)
        dict["account_timestamp"] = self.encodeData(stringToEncode: self.inspetorDateFormatter(time: self.timestamp))
        dict["account_phone_number"] = self.encodeData(stringToEncode: self.phone_number)
        
        return dict
    }
}
