//
//  PassRecovery.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class PassRecovery: AbstractModel, InspetorSerialize {
    
    //MARK: Actions
    enum passwordActions: String {
        case reset = "password_reset"
        case recovery = "password_recovery"
    }
    
    //MARK: Properties
    var recoveryEmail: String
    var timestamp: Int
    
    //MARK: init
    init(recoveryEmail: String, timestamp: Int) {
        self.recoveryEmail = recoveryEmail
        self.timestamp = timestamp
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["pass_recovery_email"] = self.encodeData(stringToEncode: self.recoveryEmail)
        dict["pass_recovery_timestamp"] = self.encodeData(stringToEncode: self.inspetorDateFormatter(time: self.timestamp))
        
        return dict
    }
    
}
