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
    
    internal init?(authToken: String, inspetorEnv: Bool = false) {
        // Validating the authToken as soon as we get it
        if (authToken.isEmpty) {
            return nil
        }
        
        let splittedToken = authToken.split(separator: ".")
        if (splittedToken.count != 3) {
            return nil
        }
        
        guard let principalId = InspetorConfig.getPrincipalId(authTokenPart: String(splittedToken[1])) else {
            return nil
        }
        
        self.authToken = authToken
        self.inspetorEnv = inspetorEnv
        self.devEnv = principalId.lowercased().contains("sandbox")
    }
    
    private static func getPrincipalId(authTokenPart: String) -> String? {
        // We may need to add "=" at the end of the word if it's not a multiple of 4
        let b64encoded = authTokenPart.padding(toLength: ((authTokenPart.count+3)/4)*4, withPad: "=",startingAt: 0)
        if let data = Data(base64Encoded: b64encoded) {
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:String] else {
                return nil
            }
            return json["principalId"] ?? nil
        }
        return nil
    }
    
}
