//
//  Item.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class Item: AbstractModel, InspetorSerialize {

    //MARK: Properties
    var id: String
    var eventId: String
    var sessionId: String
    var price: Double
    var seatingOption: String?
    var quantity: Int
    
    //MARK: init
    init(id: String, eventId: String, sessionId: String, price: Double, quantity: Int) {
        self.id = id
        self.eventId = eventId
        self.sessionId = sessionId
        self.price = price
        self.quantity = quantity
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["item_id"] = self.encodeData(stringToEncode: self.id)
        dict["item_event_id"] = self.encodeData(stringToEncode: self.eventId)
        dict["item_session_id"] = self.encodeData(stringToEncode: self.sessionId)
        dict["item_price"] = self.encodeData(stringToEncode: String(self.price))
        dict["item_seating_option"] = self.encodeData(stringToEncode: self.seatingOption)
        dict["item_quantity"] = self.encodeData(stringToEncode: String(self.quantity))
        
        return dict
    }
    
}
