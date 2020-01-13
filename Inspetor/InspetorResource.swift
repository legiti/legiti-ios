//
//  InspetorNewResource.swift
//  Inspetor
//
//  Created by Lourenço Biselli on 11/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker
import INTULocationManager

class InspetorResource: NSObject, InspetorResourceService {
    
    //MARK: Properties
    internal var inspetorConfig: InspetorConfig
    internal var tracker: SPTracker?
    private var inspetorGeoLocation: InspetorGeoLocation = InspetorGeoLocation.sharedInstance
    
    //MARK: init
    init(inspetorConfig: InspetorConfig) {
        self.inspetorConfig = inspetorConfig
        super.init()
        //Get the Snowplow tracker through our SnoplowManager Class
        SnowplowManager.sharedInstance.inspetorConfig = self.inspetorConfig
        self.tracker = SnowplowManager.sharedInstance.getTracker()
    }
        
    //MARK: TrackActions
    internal func trackPageView(pageTitle: String) {
        
        // Although we are using pageView as the name for this function we are using the snowplow
        // screenView function. We are doing this since we want to maintain function name consistency
        // in all of our frontend libraries
        guard let screenViewEvent = SPScreenView.build({ (builder: SPScreenViewBuilder?) -> Void in
            builder!.setName(pageTitle)
            if let fingerprintContext = self.getFingerprintContext() {
                builder!.setContexts(NSMutableArray(array: [fingerprintContext]))
            }
        }) else {
            print("InspetorLog: An error occured")
            return
        }
        
        self.trackEvent(screenViewEvent: screenViewEvent)
    }
    
    internal func trackAccountAction(data: Dictionary<String, String?>, action: Actions.accountActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorAccountSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("InspetorLog: An error occured")
            return
        }
                
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackAccountAuthAction(data: Dictionary<String, String?>, action: Actions.authActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorAuthSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
           print("InspetorLog: An error occured")
           return
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackEventAction(data: Dictionary<String, String?>, action: Actions.eventAction) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorEventSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("InspetorLog: An error occured")
            return
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackItemTransferAction(data: Dictionary<String, String?>, action: Actions.transferActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorItemTransferSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("InspetorLog: An error occured")
            return
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackPasswordRecoveryAction(data: Dictionary<String, String?>, action: Actions.passRecoveryActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorPassRecoverySchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("InspetorLog: An error occured")
            return
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackSaleAction(data: Dictionary<String, String?>, action: Actions.saleActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorSaleSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("InspetorLog: An error occured")
            return
        }

        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    //MARK: Helper Functions        
    private func createUnstructuredEvent(schema: String, data: NSDictionary, action: String) -> SPUnstructured? {
        
        let contextData: NSDictionary = ["action": action]
        
        let sdj = SPSelfDescribingJson(schema: schema, andData: data)
        
        let actionContext = SPSelfDescribingJson(
            schema: InspetorDependencies.inspetorActionContextSchema,
            andData: contextData
        )
        
        guard let unstructedEvent = SPUnstructured.build({ (builder: SPUnstructuredBuilder?) -> Void in
            builder!.setEventData(sdj)
            
            var contextArray = [actionContext!]
            if let deviceFingerprint = self.getFingerprintContext() {
                contextArray.append(deviceFingerprint)
            }
            builder!.setContexts(NSMutableArray(array: NSMutableArray(array: contextArray)))
        }) else {
            return nil
        }
        
        return unstructedEvent
    }
    
    
    //MARK: TrackEvent
    private func trackEvent(unstructedEvent: SPUnstructured) {
        if self.inspetorGeoLocation.currentLocation != nil {
            self.tracker!.setSubject(InspetorGeoLocation.sharedInstance.getLocationSubject())
            self.tracker!.trackUnstructuredEvent(unstructedEvent)
        } else {
            self.tracker!.trackUnstructuredEvent(unstructedEvent)
        }
    }
    
    private func trackEvent(screenViewEvent: SPScreenView) {
        if self.inspetorGeoLocation.currentLocation != nil {
            self.tracker!.setSubject(InspetorGeoLocation.sharedInstance.getLocationSubject())
            self.tracker!.trackScreenViewEvent(screenViewEvent)
        } else {
            self.tracker!.trackScreenViewEvent(screenViewEvent)
        }
    }
    
    
    //MARK: FingerprintContext
    private func getFingerprintContext() -> SPSelfDescribingJson? {
        let deviceContext = InspetorDeviceData().getDeviceData()

        let fingerprintContext = SPSelfDescribingJson(
            schema: InspetorDependencies.inspetorFingerprintContextSchema,
            andData: (deviceContext as NSDictionary)
        )
        return fingerprintContext!
    }
    
}
