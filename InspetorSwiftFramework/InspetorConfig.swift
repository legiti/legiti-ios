//
//  InspetorConfig.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 11/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

struct InspetorConfig {
    
    var defaultCollectorHost: String = InspetorDependencies.defaultCollectorHost
    var appId: String
    var nameTracker: String
    
    init(appId: String, nameTracker: String) {
        self.appId = appId
        self.nameTracker = nameTracker
    }
    
}
