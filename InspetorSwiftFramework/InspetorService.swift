//
//  inspetorService.swift
//  inspetor-ios-sdk
//
//  Created by Pearson Henri on 3/21/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

public class inspetorService: NSObject {
    var trackerName: String
    var appId: String
    var base64Encoded: Bool
    var collectorUri : String
    var httpMethodType : SPRequestOptions
    var protocolType : SPProtocol
    
    var tracker : SPTracker?
    
    public init(trackerName: String,
                appId: String,
                base64Encoded: Bool? = nil,
                collectorUri : String? = nil,
                httpMethodType : SPRequestOptions? = nil,
                protocolType : SPProtocol? = nil)
    {
        // set values
        self.trackerName = trackerName
        self.appId = appId
        self.base64Encoded = base64Encoded ?? true
        self.collectorUri = collectorUri ?? "analytics-staging.useinspetor.com"
        //        self.collectorUri = collectorUri ?? "analytics.useinspetor.com"
        self.httpMethodType = httpMethodType ?? SPRequestOptions.get
        self.protocolType = protocolType ?? SPProtocol.https
        
        super.init()
        
        // initialize tracker
        self.tracker = initializeTracker()
    }
    
    private func initializeTracker() -> SPTracker {
        let emitter = SPEmitter.build({ (builder : SPEmitterBuilder?) -> Void in
            builder!.setUrlEndpoint(self.collectorUri)
            builder!.setHttpMethod(self.httpMethodType)
        })
        
        let newTracker = SPTracker.build({ (builder: SPTrackerBuilder?) -> Void in
            builder!.setEmitter(emitter)
            builder!.setAppId(self.appId)
            builder!.setTrackerNamespace(self.trackerName)
            builder!.setBase64Encoded(self.base64Encoded)
            
        })
        
        return newTracker!
    }
    
    public func trackPageView() {
        let event = SPScreenView.build({ (builder : SPScreenViewBuilder?) -> Void in
            builder!.setName("DemoScreenName")
            builder!.setId("DemoScreenId")
        })
        self.tracker!.trackScreenViewEvent(event)
        
        print("******* tracked a screen view event mofucka! ********")
    }
}
