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

public class InspetorResource: NSObject {
    internal let DEFAULT_BASE64_OPTION: Bool = true
//    internal let DEFAULT_COLLECTOR_URI: String = "analytics.useinspetor.com"
    internal let DEFAULT_COLLECTOR_URI: String = "analytics-staging.useinspetor.com"
    internal let DEFAULT_HTTP_METHOD_TYPE: SPRequestOptions = SPRequestOptions.get
    internal let DEFAULT_PROTOCOL_TYPE: SPProtocol = SPProtocol.https
    internal let DEFAULT_INSPETOR_TRACKER_NAME_SEPARATOR: Character = "."
    
    private var base64Encoded: Bool
    private var collectorUri: String
    private var httpMethodType: SPRequestOptions
    private var protocolType: SPProtocol
    private var subject: SPSubject
    
    private var trackerName: String?
    private var appId: String?
    private var clientName: String?
    private var tracker: SPTracker?
    
    public override init() {
        self.base64Encoded = self.DEFAULT_BASE64_OPTION
        self.collectorUri = self.DEFAULT_COLLECTOR_URI
        self.httpMethodType = self.DEFAULT_HTTP_METHOD_TYPE
        self.protocolType = self.DEFAULT_PROTOCOL_TYPE
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
        self.clientName = String(trackerName.split(separator: self.DEFAULT_INSPETOR_TRACKER_NAME_SEPARATOR)[0])

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
    
    public func setActiveUser(_ userId: Int) {
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
    
    public func trackLogin(_ userId: Int) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "login",
            "user_id",
            String(userId)
        )
        
        self.setActiveUser(userId)
        self.tracker!.trackStructuredEvent(event)
    }
    
    public func trackLogout() {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "logout",
            "user_id",
            "see_user_id_field"
        )
        
        self.tracker!.trackStructuredEvent(event)
        self.unsetActiveUser()
    }

    public func trackAccountCreation(_ userId: Int) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "create_user",
            "user_id",
            String(userId)
        )

        self.tracker!.trackStructuredEvent(event)
    }

    public func trackAccountUpdate(_ updateType: InspetorAccountUpdateType) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "update_user",
            "update_type",
            updateType.rawValue
        )

        self.tracker!.trackStructuredEvent(event)
    }
    
    public func trackCreateOrder(_ transactionId: String) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "create_order",
            "transaction_id",
            transactionId
        )
        
        self.tracker!.trackStructuredEvent(event)
    }
    
    public func trackPayOrder(_ transactionId: String) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "pay_order",
            "transaction_id",
            transactionId
        )
        
        self.tracker!.trackStructuredEvent(event)
    }
    
    public func trackCancelOrder(_ transactionId: String) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "cancel_order",
            "transaction_id",
            transactionId
        )
        
        self.tracker!.trackStructuredEvent(event)
    }
    
    public func trackTicketTransfer(_ ticket_id: String) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "ticket_transfer",
            "ticket_id",
            ticket_id
        )
        
        self.tracker!.trackStructuredEvent(event)
    }
    
    public func trackRecoverPasswordRequest(_ email: String) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "recover_password_request",
            "email",
            email
        )
        
        self.tracker!.trackStructuredEvent(event)
    }
    
    public func trackChangePassword(_ email: String) {
        precondition(self.verifySetup())

        let event = self.structuredEventBuilderHelper(
            self.clientName!,
            "change_password",
            "email",
            email
        )
        
        self.tracker!.trackStructuredEvent(event)
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
        let trackerNameArray = trackerName.split(separator: DEFAULT_INSPETOR_TRACKER_NAME_SEPARATOR)
        
        return(trackerNameArray.count == 2 &&
            trackerNameArray[0].count > 1 &&
            trackerNameArray[1].count > 1
        )
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
