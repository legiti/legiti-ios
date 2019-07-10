//
//  Transfer.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class Transfer: AbstractModel, InspetorSerialize {
    
    //MARK: Actions
    enum transferActions: String {
        case create = "transfer_create"
        case updateStatus = "transfer_update_status"
    }
    
    //MARK: Status
    enum transferStatus: String {
        case accepted = "accepted"
        case rejected = "rejected"
        case pending = "pending"
    }
    
    //MARK: Properties
    var id: String
    var timestamp: Int
    var itemId: String
    var senderAccountId: String
    var receiverEmail: String
    var status: transferStatus
    
    //MARK: init
    init(id: String, timestamp: Int, itemId: String, senderAccountId: String, receiverEmail: String, status: transferStatus) {
        self.id = id
        self.timestamp = timestamp
        self.itemId = itemId
        self.senderAccountId = senderAccountId
        self.receiverEmail = receiverEmail
        self.status = status
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["transfer_id"] = self.encodeData(stringToEncode: self.id)
        dict["transfer_timestamp"] = self.encodeData(stringToEncode: self.inspetorDateFormatter(time: self.timestamp))
        dict["transfer_item_id"] = self.encodeData(stringToEncode: self.itemId)
        dict["transfer_sender_account_id"] = self.encodeData(stringToEncode: self.senderAccountId)
        dict["transfer_receiver_email"] = self.encodeData(stringToEncode: self.receiverEmail)
        dict["transfer_status"] = self.encodeData(stringToEncode: self.status.rawValue)
        
        return dict
    }
    
}
