//
//  Inspetor.swift
//  Inspetor
//
//  Created by Lourenço Biselli on 12/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

public class Inspetor {
    
    private static let instance: InspetorClient = InspetorClient()
    
    public static func sharedInstance() -> InspetorClient {
        let _ = InspetorGeoLocation.sharedInstance
        return self.instance
    }
    
}
