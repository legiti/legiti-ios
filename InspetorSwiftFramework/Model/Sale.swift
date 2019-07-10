//
//  Sale.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class Sale: AbstractModel, InspetorSerialize {
    
    //MARK: Actions
    enum saleActions: String {
        case create = "sale_create"
        case update = "sale_update"
    }
    
    //MARK: Status
    enum saleStatus: String {
        case accepted = "accepted"
        case declined = "declined"
        case pending  = "pending"
        case refunded = "refunded"
        case manual_analysis = "manual_analysis";
    }
    
    //MARK: Properties
    var id: String
    var accountId: String
    private var totalValue: Double
    var status: saleStatus
    var isFraud: Bool
    var timestamp: Int
    var items: [Item]
    var payment: Payment
    
    //MARK: init
    init(id: String, accountId: String, status: saleStatus, isFraud: Bool, timestamp: Int, items: [Item], payment: Payment) {
        self.id = id
        self.accountId = accountId
        self.status = status
        self.isFraud = isFraud
        self.timestamp = timestamp
        self.items = items
        self.payment = payment
        self.totalValue = 0.0
        
        super.init()
        self.totalValue = self.calculateTotalValue()

    }
    
    //MARK: Helper Functions
    private func calculateTotalValue() -> Double {
        var value: Double = 0.0
        for item in self.items {
            value = value + (item.price * Double(item.quantity))
        }
        return value
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["sale_id"] = self.encodeData(stringToEncode: self.id)
        dict["sale_account_id"] = self.encodeData(stringToEncode: self.accountId)
        dict["sale_total_value"] = self.encodeData(stringToEncode: String(self.totalValue))
        dict["sale_status"] = self.encodeData(stringToEncode: self.status.rawValue)
        dict["sale_is_fraud"] = self.encodeData(stringToEncode: String(self.isFraud))
        dict["sale_timestamp"] = self.encodeData(stringToEncode: self.inspetorDateFormatter(time: self.timestamp))
        dict["sale_items"] = self.encodeArray(arrayToEncode: self.items, isObject: true)
        dict["sale_payment_instance"] = self.encodeObject(objectToEncode: self.payment)
        
        return dict
    }
    
}
