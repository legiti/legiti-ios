//
//  Inspetor.swift
//  Inspetor
//
//  Created by Inspetor on 12/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

public class Inspetor {
    
    public static let sharedInstance: InspetorClient = InspetorClient()
    
    static public func isConfigured() -> Bool {
        if (sharedInstance.inspetorConfig == nil) {
            return false
        }
        return true
    }
    
}
