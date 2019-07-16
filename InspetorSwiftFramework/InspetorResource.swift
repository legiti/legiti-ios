//
//  InspetorNewResource.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 11/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

class InspetorResource: NSObject, InspetorResourceService, SPRequestCallback {
    
    func onSuccess(withCount successCount: Int) {
        print("Success: \(successCount)")
    }
    
    func onFailure(withCount failureCount: Int, successCount: Int) {
        print(failureCount)
    }
    
    
    //MARK: Properties
    var inspetorConfig: InspetorConfig

    
    internal var httpMethodType: SPRequestOptions = InspetorDependencies.defaultHttpMethodType
    internal var base64Encoded: Bool = InspetorDependencies.defaultBase64Option
    internal var protocolType: SPProtocol = InspetorDependencies.defaultProtocolType
    
    internal var tracker: SPTracker?
    
    //MARK: init
    init?(inspetorConfig: InspetorConfig) {
        self.inspetorConfig = inspetorConfig
        super.init()
        guard let newTracker = self.setupTracker() else {
            //fail the init
            return nil
        }
        self.tracker = newTracker
    }
    
    //MARK: Setup Tracker
    private func setupTracker() -> SPTracker? {
        
         guard let emitter = SPEmitter.build({ (builder : SPEmitterBuilder?) -> Void in
            builder!.setUrlEndpoint(self.inspetorConfig.defaultCollectorHost)
            builder!.setHttpMethod(self.httpMethodType)
            builder!.setProtocol(self.protocolType)
            builder!.setCallback(self)
         }) else {
            return nil
        }
        
        let subject = self.getSPSubject()
        
        guard let newTracker = SPTracker.build({ (builder: SPTrackerBuilder?) -> Void in
            builder!.setEmitter(emitter)
            builder!.setAppId(self.inspetorConfig.appId)
            builder!.setTrackerNamespace(self.inspetorConfig.nameTracker)
            builder!.setBase64Encoded(self.base64Encoded)
            builder!.setApplicationContext(true)
            builder!.setSubject(subject)
        }) else {
            return nil
        }

        return newTracker
    }
    
    
    
    //MARK: Helper Functions
    private func getSPSubject() -> SPSubject {
        return SPSubject(platformContext: true, andGeoContext: true)
    }
    
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
    
    //MARK: ActiveUser
    private func setActiveUser(userId: String) {
        let subject = self.getSPSubject()
        subject.setUserId(String(userId))
        self.tracker!.setSubject(subject)
    }
    
    public func unsetActiveUser() {
        let subject = self.getSPSubject()
        subject.setUserId("")
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
        
        self.tracker!.trackUnstructuredEvent(unstructedEvent)
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
            self.setActiveUser(userId: self.decodeBase64Data(data: data["auth_account_id"]!))
        } else {
            self.unsetActiveUser()
        }
              
        self.tracker!.trackUnstructuredEvent(unstructedEvent)
    }
    
    internal func trackEventAction(data: Dictionary<String, String>, action: Actions.eventAction) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorEventSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }
        
        self.tracker!.trackUnstructuredEvent(unstructedEvent)
    }
    
    internal func trackItemTransferAction(data: Dictionary<String, String>, action: Actions.transferActions) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorItemTransferSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }
        
        self.tracker!.trackUnstructuredEvent(unstructedEvent)
    }
    
    internal func trackPasswordRecoveryAction(data: Dictionary<String, String>, action: Actions.passRecoveryActions) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorPassRecoverySchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }
        
        self.tracker!.trackUnstructuredEvent(unstructedEvent)
    }
    
    internal func trackSaleAction(data: Dictionary<String, String>, action: Actions.saleActions) throws {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: InspetorDependencies.inspetorSaleSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            throw TrackerException.internalError(message: "An error occured")
        }
        
        self.tracker!.trackUnstructuredEvent(unstructedEvent)
    }
    
    
}
