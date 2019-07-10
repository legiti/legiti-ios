//
//  Auth.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class Auth: AbstractModel, InspetorSerialize {
    
    //MARK: Actions
    enum authActions: String {
        case login = "account_login"
        case logout = "account_logout"
    }
    
    //MARK: Properties
    var accountId: String
    var accountEmail: String?
    var timestamp: Int
    
    //MARK: init
    init(accountId: String, timestamp: Int) {
        self.accountId = accountId
        self.timestamp = timestamp
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["auth_account_id"] = self.encodeData(stringToEncode: self.accountId)
        dict["auth_account_email"] = self.encodeData(stringToEncode: self.accountEmail)
        dict["auth_timestamp"] = self.encodeData(stringToEncode: self.inspetorDateFormatter(time: self.timestamp))
        
        return dict
    }
    
}
