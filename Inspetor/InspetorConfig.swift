//
//  InspetorConfig.swift
//  Inspetor
//
//  Created by Inspetor on 11/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

public struct InspetorConfig {
    
    public var devEnv: Bool
    public var appId: String
    public var trackerName: String
    
    public init(appId: String, trackerName: String, devEnv: Bool = false) {
        self.appId = appId
        self.trackerName = trackerName
        self.devEnv = devEnv
    }
    
    internal func isValid() -> Bool {
        
        if (self.appId.isEmpty || self.trackerName.isEmpty) {
            return false
        }
        
        if !(self.isValidtrackerName()) {
            return false
        }
        
        return true
    }
    
    private func isValidtrackerName() -> Bool {
        let splitedtrackerName = self.trackerName.split(separator: ".")
        
        if splitedtrackerName.count < 2 {
            return false
        }
        
        for parttrackerName in splitedtrackerName {
            if parttrackerName.count <= 1 {
                return false
            }
        }
        
        return true
    }
    
}
