//
//  InspetorConfig.swift
//  Inspetor
//
//  Created by Lourenço Biselli on 11/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

internal struct InspetorConfig {
    
    internal var devEnv: Bool
    internal var inspetorEnv: Bool
    internal var appId: String
    internal var trackerName: String
    
    internal init(appId: String, trackerName: String, devEnv: Bool = false, inspetorEnv: Bool = false) {
        self.appId = appId
        self.trackerName = trackerName
        self.devEnv = devEnv
        self.inspetorEnv = inspetorEnv
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
        let splitedTrackerName = self.trackerName.split(separator: ".")
        
        if splitedTrackerName.count < 2 {
            return false
        }
        
        for partTrackerName in splitedTrackerName {
            if partTrackerName.count <= 1 {
                return false
            }
        }
        
        return true
    }
    
}
