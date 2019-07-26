//
//  InspetorSnowplowManager.swift
//  Inspetor
//
//  Created by Lourenço Biselli on 18/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

internal class SnowplowManager {
    
    //MARK: Properties
    internal var inspetorConfig: InspetorConfig?
    private let inspetorEmitterCallback: InspetorEmitterCallback = InspetorEmitterCallback()
    private var tracker: SPTracker?
    
    static internal var sharedInstance: SnowplowManager = SnowplowManager()
    
    //MARK: Setup Tracker
    private func setupTracker(inspetorConfig: InspetorConfig) -> SPTracker? {
        
        var postPath = ""
        var urlEndpoint = InspetorDependencies.defaultCollectorURL
        
        if (inspetorConfig.devEnv) {
            postPath = InspetorDependencies.stagingPostPath
        } else {
            postPath = InspetorDependencies.prodPostPath
        }
        
        if (inspetorConfig.inspetorEnv) {
            urlEndpoint = "test.com/"
        }
        
        guard let emitter = SPEmitter.build({ (builder : SPEmitterBuilder?) -> Void in
            builder!.setCustomPostPath(postPath)
            builder!.setUrlEndpoint(urlEndpoint)
            builder!.setHttpMethod(InspetorDependencies.defaultHttpMethodType)
            builder!.setProtocol(InspetorDependencies.defaultProtocolType)
            builder!.setCallback(self.inspetorEmitterCallback)
        }) else {
            return nil
        }
        
        let subject = SPSubject(platformContext: true, andGeoContext: true)
        
        guard let newTracker = SPTracker.build({ (builder: SPTrackerBuilder?) -> Void in
            builder!.setEmitter(emitter)
            builder!.setAppId(inspetorConfig.appId)
            builder!.setTrackerNamespace(inspetorConfig.trackerName)
            builder!.setBase64Encoded(InspetorDependencies.defaultBase64Option)
            builder!.setApplicationContext(true)
            builder!.setSessionContext(true)
            builder!.setSubject(subject)
        }) else {
            return nil
        }
        
        return newTracker
    }
    
    //MARK: getTracker
    internal func getTracker() -> SPTracker {
        
        if self.tracker == nil {
            if self.inspetorConfig == nil {
                fatalError("Error in the Inspetor Framework")
            }
            self.tracker = setupTracker(inspetorConfig: self.inspetorConfig!)
        }
        
        return self.tracker!
    }
    
    internal func getSubject() -> SPSubject {
        return SPSubject(platformContext: true, andGeoContext: true)
    }
}
