//
//  InspetorResource.swift
//  inspetor-ios-sdk
//
//  Created by Pearson Henri on 3/21/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

public enum InspetorAccountUpdateType: String {
    case user_info, password, billing_info
}

public class InspetorResource: NSObject, InspetorService {    
    internal var base64Encoded: Bool
    internal var collectorUri: String
    internal var httpMethodType: SPRequestOptions
    internal var protocolType: SPProtocol
    internal var subject: SPSubject
    
    internal var trackerName: String?
    internal var appId: String?
    internal var clientName: String?
    internal var tracker: SPTracker?
    
    public override init() {
        self.base64Encoded = InspetorConfig.DEFAULT_BASE64_OPTION
        self.collectorUri = InspetorConfig.DEFAULT_COLLECTOR_URI
        self.httpMethodType = InspetorConfig.DEFAULT_HTTP_METHOD_TYPE
        self.protocolType = InspetorConfig.DEFAULT_PROTOCOL_TYPE
        self.subject = SPSubject()!
        
        super.init()
    }
    
    public func setup(trackerName: String,
                appId: String,
                base64Encoded: Bool? = nil,
                collectorUri : String? = nil,
                httpMethodType : SPRequestOptions? = nil,
                protocolType : SPProtocol? = nil)
    {
        precondition(self.validateTrackerName(trackerName))
        
        self.trackerName = trackerName
        self.appId = appId
        self.clientName = String(trackerName.split(separator: InspetorConfig.DEFAULT_INSPETOR_TRACKER_NAME_SEPARATOR)[0])

        if (base64Encoded != nil) {
            self.base64Encoded = base64Encoded!
        }
        if (collectorUri != nil) {
            self.collectorUri = collectorUri!
        }
        if (httpMethodType != nil) {
            self.httpMethodType = httpMethodType!
        }
        if (protocolType != nil) {
            self.protocolType = protocolType!
        }

        self.tracker = initializeTracker()
        
        precondition(self.verifySetup())
    }
    
    // Accessors
    public func getBase64Encoded() -> Bool {
        return self.base64Encoded
    }
    
    public func getCollectorUri() -> String {
        return self.collectorUri
    }
    
    public func getHttpMethodType() -> SPRequestOptions {
        return self.httpMethodType
    }
    
    public func getProtocolType() -> SPProtocol {
        return self.protocolType
    }
    
    public func getSubject() -> SPSubject {
        return self.subject
    }
    
    public func getTrackerName() -> String? {
        return self.trackerName
    }

    public func getAppId() -> String? {
        return self.appId
    }
    
    public func setActiveUser(_ userId: String) {
        precondition(self.verifySetup())

        self.subject.setUserId(String(userId))
        self.tracker!.setSubject(subject)
    }
    
    public func unsetActiveUser() {
        if (!self.verifySetup()) {
            return
        }

        self.subject.setUserId("")
        self.tracker!.setSubject(subject)
    }
    
    public func trackLogin(_ userId: String) {
        precondition(self.verifySetup())
        
        self.setActiveUser(userId)
        let data: NSDictionary = ["userId": String(userId)]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_LOGIN_SCHEMA_VERSION, data: data)
    }
    
    public func trackLogout(_ userId: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["userId": userId]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_LOGOUT_SCHEMA_VERSION, data: data)
        self.unsetActiveUser()
    }

    public func trackAccountCreation(_ userId: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["userId": userId]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_ACCOUNT_CREATION_SCHEMA_VERSION, data: data)
    }

    public func trackAccountUpdate(_ userId: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["userId": String(userId)]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_ACCOUNT_UPDATE_SCHEMA_VERSION, data: data)
    }
    
    public func trackCreateOrder(_ transactionId: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["transactionId": transactionId]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_CREATE_ORDER_SCHEMA_VERSION, data: data)
    }
    
    public func trackPayOrder(_ transactionId: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["transactionId": transactionId]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_PAY_ORDER_SCHEMA_VERSION, data: data)
    }
    
    public func trackCancelOrder(_ transactionId: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["transactionId": transactionId]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_CANCEL_ORDER_SCHEMA_VERSION, data: data)
    }
    
    public func trackTicketTransfer(ticketId: String, userId: String, recipient: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["ticketId": ticketId, "user": userId, "recipient": recipient]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_TICKET_TRANSFER_SCHEMA_VERSION, data: data)
    }
    
    public func trackRecoverPasswordRequest(_ email: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["email": email]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_RECOVER_PASSWORD_SCHEMA_VERSION, data: data)
    }
    
    public func trackChangePassword(_ email: String) {
        precondition(self.verifySetup())

        let data: NSDictionary = ["email": email]
        self.trackUnstructuredEvent(schema: InspetorConfig.FRONTEND_CHANGE_PASSWORD_SCHEMA_VERSION, data: data)
    }
    
    private func initializeTracker() -> SPTracker {
        let emitter = SPEmitter.build({ (builder : SPEmitterBuilder?) -> Void in
            builder!.setUrlEndpoint(self.collectorUri)
            builder!.setHttpMethod(self.httpMethodType)
        })
        
        let newTracker = SPTracker.build({ (builder: SPTrackerBuilder?) -> Void in
            builder!.setEmitter(emitter)
            builder!.setAppId(self.appId!)
            builder!.setTrackerNamespace(self.trackerName!)
            builder!.setBase64Encoded(self.base64Encoded)
        })
        
        return newTracker!
    }

    internal func verifySetup() -> Bool {
        return (self.trackerName != nil && self.appId != nil && self.tracker != nil)
    }
    
    internal func validateTrackerName(_ trackerName: String) -> Bool {
        let trackerNameArray = trackerName.split(separator: InspetorConfig.DEFAULT_INSPETOR_TRACKER_NAME_SEPARATOR)
        
        return(trackerNameArray.count == 2 &&
            trackerNameArray[0].count > 1 &&
            trackerNameArray[1].count > 1
        )
    }
    
    private func trackUnstructuredEvent(schema: String, data: NSDictionary) {
        let sdj = SPSelfDescribingJson(schema: schema, andData: data)
        let event = SPUnstructured.build({ (builder : SPUnstructuredBuilder?) -> Void in
            builder!.setEventData(sdj!)
        })

        self.tracker!.trackUnstructuredEvent(event)
    }
    
    private func structuredEventBuilderHelper(_ category: String,
                                        _ action: String,
                                        _ label: String,
                                        _ property: String) -> SPStructured {
        let event = SPStructured.build({ (builder : SPStructuredBuilder?) -> Void in
            builder!.setCategory(category)
            builder!.setAction(action)
            builder!.setLabel(label)
            builder!.setProperty(property)
        })
        
        return event!
    }
}
