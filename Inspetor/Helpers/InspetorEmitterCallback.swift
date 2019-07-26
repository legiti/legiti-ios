//
//  InspetorEmitterCallback.swift
//  Inspetor
//
//  Created by Lourenço Biselli on 16/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

internal class InspetorEmitterCallback: NSObject, SPRequestCallback {
    
    func onSuccess(withCount successCount: Int) {
        var activity = "activity"
        var wasOrWere = "was"
        
        if successCount > 1 {
            activity = "activities"
            wasOrWere = "were"
        }
        
        print("InspetorLog: \(successCount) \(activity) \(wasOrWere) sent to Inspetor")
        
    }
    
    func onFailure(withCount failureCount: Int, successCount: Int) {
        var activity = "activity"
        var wasOrWere = "was"
        
        if successCount > 1 {
            activity = "activities"
            wasOrWere = "were"
        }
        
        print("InspetorLog: \(successCount) \(activity) \(wasOrWere) not sent to Inspetor, because an error happend")
    }
    
    
}
