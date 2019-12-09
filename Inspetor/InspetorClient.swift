//
//  InspetorClient.swift
//  Inspetor
//
//  Created by Lourenço Biselli on 12/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

public class InspetorClient: InspetorClientService {
    
    //MARK: Properties
    private var inspetorResource: InspetorResource?
    private var inspetorConfig: InspetorConfig?
    private let errorMessage9001 = "AppId and trackerName are required parameters"
    private let errorMessage9002 = "AuthToken is not valid"
    
    //MARK: setup
    public func setup(authToken: String, inspetorEnv: Bool = false) throws {
        self.inspetorConfig = InspetorConfig(authToken: authToken, inspetorEnv: inspetorEnv)
        
        if !(self.inspetorConfig!.isValid()) {
            //deinitialize object and throw exception
            self.inspetorConfig = nil
            throw TrackerException.requiredConfig(code: 9002, message: self.errorMessage9002)
        }
    }
    
    //MARK: trackers
    public func trackPageView(pageTitle: String) throws {
        try self.verifyResource()
        self.inspetorResource!.trackPageView(pageTitle: pageTitle)
    }
    
    public func trackAccountCreation(accountId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: accountId, prefix: "account")
        self.inspetorResource!.trackAccountAction(data: data, action: .create)
    }
    
    public func trackAccountDeletion(accountId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: accountId, prefix: "account")
        self.inspetorResource!.trackAccountAction(data: data, action: .delete)
    }
    
    public func trackAccountUpdate(accountId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: accountId, prefix: "account")
        self.inspetorResource!.trackAccountAction(data: data, action: .update)
    }
    
    public func trackEventCreation(eventId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: eventId, prefix: "event")
        self.inspetorResource!.trackEventAction(data: data, action: .create)
    }
    
    public func trackEventDeletion(eventId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: eventId, prefix: "event")
        self.inspetorResource!.trackEventAction(data: data, action: .delete)
    }
    
    public func trackEventUpdate(eventId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: eventId, prefix: "event")
        self.inspetorResource!.trackEventAction(data: data, action: .update)
    }
    
    public func trackItemTransferCreation(transferId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: transferId, prefix: "transfer")
        self.inspetorResource!.trackItemTransferAction(data: data, action: .create)
    }
    
    public func trackItemTransferUpdate(transferId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: transferId, prefix: "transfer")
        self.inspetorResource!.trackItemTransferAction(data: data, action: .updateStatus)
    }
    
    public func trackLogin(accountEmail: String, accountId: String?) throws {
        try self.verifyResource()
        
        var data = self.createJson(id: accountEmail, prefix: "auth", idSufix: "account_email")
        // Inline if for encoding data if accountId was passed
        data["auth_account_id"] = accountId != nil ? self.encodeData(stringToEncode: accountId!) : nil
        
        self.inspetorResource!.trackAccountAuthAction(data: data, action: .login)
    }
    
    public func trackLogout(accountEmail: String, accountId: String?) throws {
        try self.verifyResource()
        
        var data = self.createJson(id: accountEmail, prefix: "auth", idSufix: "account_email")
        // Inline if for encoding data if accountId was passed
        data["auth_account_id"] = accountId != nil ? self.encodeData(stringToEncode: accountId!) : nil

        self.inspetorResource!.trackAccountAuthAction(data: data, action: .logout)
    }
    
    public func trackPasswordRecovery(accountEmail: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: accountEmail, prefix: "pass_recovery", idSufix: "email")
        self.inspetorResource!.trackPasswordRecoveryAction(data: data, action: .recovery)
    }
    
    public func trackPasswordReset(accountEmail: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: accountEmail, prefix: "pass_recovery", idSufix: "email")
        self.inspetorResource!.trackPasswordRecoveryAction(data: data, action: .reset)
    }
    
    public func trackSaleCreation(saleId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: saleId, prefix: "sale")
        self.inspetorResource!.trackSaleAction(data: data, action: .create)
    }
    
    public func trackSaleUpdate(saleId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: saleId, prefix: "sale")
        self.inspetorResource!.trackSaleAction(data: data, action: .update)
    }
    
    
    //MARK: Helper Functions
    private func getInspetorTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'+00:00'"
        
        return formatter.string(from: Date())
    }
    
    private func encodeData(stringToEncode: String) -> String {
        if let data = stringToEncode.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return ""
    }
    
    private func createJson(id: String, prefix: String, idSufix: String = "id", timestampSufix: String = "timestamp") -> Dictionary<String, String?> {
        var dict = [String: String?]()
        
        let idProperty = "\(prefix)_\(idSufix)"
        let timestampProperty = "\(prefix)_\(timestampSufix)"
        
        dict[idProperty] = self.encodeData(stringToEncode: id)
        dict[timestampProperty] = self.encodeData(stringToEncode: self.getInspetorTimestamp())
        
        return dict
    }
    
    private func verifyResource() throws {
        if !(self.isConfigured()) {
            throw TrackerException.requiredConfig(code: 9001, message: self.errorMessage9001)
        }
        
        if (self.inspetorResource == nil) {
            self.inspetorResource = InspetorResource(inspetorConfig: self.inspetorConfig!)
        }
    }
    
    public func isConfigured() -> Bool {
        if (self.inspetorConfig == nil) {
            return false
        }
        return true
    }
    
}
