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
    private let inspetorEmitterCallback: InspetorEmitterCallback = InspetorEmitterCallback()
    private var tracker: SPTracker?
    internal var inspetorConfig: InspetorConfig?
    
    private static let defaultTrackerName: String = "inspetor.ios.tracker"
    internal static var sharedInstance: SnowplowManager = SnowplowManager()
    
    //MARK: Setup Tracker
    private func setupTracker(inspetorConfig: InspetorConfig) -> SPTracker? {
        var postPath = inspetorConfig.inspetorDevEnv ? InspetorDependencies.stagingPostPath : InspetorDependencies.prodPostPath

        guard let emitter = SPEmitter.build({ (builder : SPEmitterBuilder?) -> Void in
            builder!.setCustomPostPath(postPath)
            builder!.setUrlEndpoint(InspetorDependencies.defaultCollectorURL)
            builder!.setHttpMethod(InspetorDependencies.defaultHttpMethodType)
            builder!.setProtocol(InspetorDependencies.defaultProtocolType)
            builder!.setCallback(self.inspetorEmitterCallback)
            builder!.setEmitThreadPoolSize(1)
            builder!.setByteLimitPost(200)
        }) else {
            return nil
        }
        
        let subject = SPSubject(platformContext: true, andGeoContext: true)
        subject!.setTimezone(TimeZone.current.identifier)
        
        guard let newTracker = SPTracker.build({ (builder: SPTrackerBuilder?) -> Void in
            builder!.setEmitter(emitter)
            builder!.setAppId(inspetorConfig.authToken)
            builder!.setTrackerNamespace(SnowplowManager.defaultTrackerName)
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
