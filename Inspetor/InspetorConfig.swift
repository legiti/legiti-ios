//
//  InspetorConfig.swift
//  Inspetor
//
//  Created by Lourenço Biselli on 11/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

internal struct InspetorConfig {

    internal var authToken: String
    internal var inspetorEnv: Bool
    internal var devEnv: Bool
    
    internal init(authToken: String, inspetorEnv: Bool = false) {
        self.authToken = authToken
        self.inspetorEnv = inspetorEnv
        self.devEnv = self.isSandboxMode()
    }
    
    internal func isValid() -> Bool {
        return !self.authToken.isEmpty && self.validateAuthToken()
    }
    
    private func validateAuthToken() -> Bool {
        return true
    }
    
    private func isSandboxMode() -> Bool {
        return true
    }
    
}
