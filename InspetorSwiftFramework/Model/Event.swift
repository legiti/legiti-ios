//
//  Event.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class Event: AbstractModel, InspetorSerialize {
    
    enum eventAction: String {
        case create = "event_create"
        case update = "event_update"
        case delete = "event_delete"
    }

    enum eventStatus: String {
        case draft     = "draft"
        case pvt       = "private"
        case published = "published"
        case other     = "other"
    }
    
    //MARK: Properties
    var id: String
    var name: String
    var description: String?
    var timestamp: Int
    var sessions: [Dictionary<String, String>]
    var status: String
    private var statusOther: String?
    var seatingOptions: [String]?
    var categories: [String]?
    var address: Address
    var url: String?
    var producerId: String
    var adminsId: [String]
    
    //MARK: init
    init(id: String, name: String, timestamp: Int, sessions: [Dictionary<String, String>], status: String, address: Address, producerId: String, adminsId: [String]) {
        self.id = id
        self.name = name
        self.timestamp = timestamp
        self.sessions = sessions
        self.status = status
        self.address = address
        self.producerId = producerId
        self.adminsId = adminsId
    }
    
    //MARK: Helper Functions
    private func validateStatus() {
        let allStatus = [eventStatus.draft.rawValue, eventStatus.pvt.rawValue, eventStatus.pvt.rawValue]
        
        if (!allStatus.contains(self.status)) {
            self.statusOther = self.status
            self.status = eventStatus.other.rawValue
        }
    }
    
    private func validateSessions() {
        for session in self.sessions {
            let keys = Array(session.keys)
            if (keys.count != 2 || !keys.contains("id") || !keys.contains("timestamp"))  {
                //should throw exception
            }
        }
    }
    
    private func encodeSessions() -> [Dictionary<String, String>] {
        var encodedSessions: [Dictionary<String, String>] = []
        
        for session in self.sessions {
            var partialSession = [String: String]()
            for (key, value) in session {
                partialSession[key] = self.encodeData(stringToEncode: value)
            }
            encodedSessions.append(partialSession)
        }
        return encodedSessions
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["event_id"] = self.encodeData(stringToEncode: self.id)
        dict["event_name"] = self.encodeData(stringToEncode: self.name)
        dict["event_description"] = self.encodeData(stringToEncode: self.description)
        dict["event_timestamp"] = self.encodeData(stringToEncode: self.inspetorDateFormatter(time: self.timestamp))
        dict["event_sessions"] = self.encodeSessions()
        dict["event_status"] = self.encodeData(stringToEncode: self.status)
        dict["event_status_other"] = self.encodeData(stringToEncode: self.statusOther)
        dict["event_seating_options"] = self.encodeArray(arrayToEncode: self.seatingOptions, isObject: false)
        dict["event_categories"] = self.encodeArray(arrayToEncode: self.categories, isObject: false)
        dict["event_address"] = self.encodeObject(objectToEncode: self.address)
        dict["event_url"] = self.encodeData(stringToEncode: self.url)
        dict["event_producer_id"] = self.encodeData(stringToEncode: self.producerId)
        dict["event_admins_id"] = self.encodeArray(arrayToEncode: self.adminsId, isObject: false)
        
        return dict
    }
}
