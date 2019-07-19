//
//  InspetorNewResource.swift
//  Inspetor
//
//  Created by Inspetor on 11/07/19.
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
    
    //MARK: ActiveUser
    private func trackActiveUser(userId: String? = nil) {
        let subject = SnowplowManager.sharedInstance.getSubject()
        subject.setUserId(userId ?? "")
        self.tracker!.setSubject(subject)
    }
    
    //MARK: TrackActions
    internal func trackAccountAction(data: Dictionary<String, String>, action: Actions.accountActions) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorAccountSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackAccountAuthAction(data: Dictionary<String, String>, action: Actions.authActions) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorAuthSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
           throw TrackerException.internalError(message: "An error occured")
        }
        
        if (action == .login) {
            self.trackActiveUser(userId: self.decodeBase64Data(data: data["auth_account_id"]!))
        } else {
            self.trackActiveUser()
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackEventAction(data: Dictionary<String, String>, action: Actions.eventAction) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorEventSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackItemTransferAction(data: Dictionary<String, String>, action: Actions.transferActions) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorItemTransferSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackPasswordRecoveryAction(data: Dictionary<String, String>, action: Actions.passRecoveryActions) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorPassRecoverySchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackSaleAction(data: Dictionary<String, String>, action: Actions.saleActions) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorSaleSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }

        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    //MARK: Helper Functions    
    private func decodeBase64Data(data: String) -> String {
        let decodedData = Data(base64Encoded: data)!
        return String(data: decodedData, encoding: .utf8)!
    }
    
    private func createUnstructuredEvent(schema: String, data: NSDictionary, action: String) -> SPUnstructured? {
        
        let contextData: NSDictionary = ["action": action]
        
        let sdj = SPSelfDescribingJson(schema: schema, andData: data)
        
        let context = SPSelfDescribingJson(
            schema: InspetorDependencies.inspetorContextSchema,
            andData: contextData
        )
        
        guard let unstructedEvent = SPUnstructured.build({ (builder: SPUnstructuredBuilder?) -> Void in
            builder!.setEventData(sdj)
            builder!.setContexts(NSMutableArray(array: NSMutableArray(array: [context!])))
        }) else {
            return nil
        }
        
        return unstructedEvent
    }
    
    private func trackEvent(unstructedEvent: SPUnstructured) {
        if self.inspetorGeoLocation.currentLocation != nil {
            self.tracker!.setSubject(InspetorGeoLocation.sharedInstance.getLocationSubject())
            self.tracker!.trackUnstructuredEvent(unstructedEvent)
        } else {
            self.tracker!.trackUnstructuredEvent(unstructedEvent)
        }
    }
    
}
