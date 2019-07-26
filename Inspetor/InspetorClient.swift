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
    private let errorMessage9002 = "AppId or/and trackerName are not valid"
    
    //MARK: init
    internal init() {
        let _ = InspetorGeoLocation.sharedInstance
    }
    
    public func setup(appId: String, trackerName: String, devEnv: Bool = false, inspetorEnv: Bool = false) throws {
        self.inspetorConfig = InspetorConfig(appId: appId, trackerName: trackerName, devEnv: devEnv, inspetorEnv: inspetorEnv)
        
        if !(self.inspetorConfig!.isValid()) {
            //deinitialize object and throw exception
            self.inspetorConfig = nil
             throw TrackerException.requiredConfig(code: 9002, message: self.errorMessage9002)
        }
    }
    
    public func trackAccountCreation(accountId: String) throws {
        let data = self.createJson(id: accountId, prefix: "account")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackAccountAction(data: data, action: .create)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
        
    }
    
    public func trackAccountDeletion(accountId: String) throws {
        let data = self.createJson(id: accountId, prefix: "account")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackAccountAction(data: data, action: .delete)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackAccountUpdate(accountId: String) throws {
        let data = self.createJson(id: accountId, prefix: "account")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackAccountAction(data: data, action: .update)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackEventCreation(eventId: String) throws {
        let data = self.createJson(id: eventId, prefix: "event")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackEventAction(data: data, action: .create)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackEventDeletion(eventId: String) throws {
        let data = self.createJson(id: eventId, prefix: "event")
        
        try self.verifyResource()

        do {
            try self.inspetorResource!.trackEventAction(data: data, action: .delete)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackEventUpdate(eventId: String) throws {
        let data = self.createJson(id: eventId, prefix: "event")
        
        try self.verifyResource()

        do {
            try self.inspetorResource!.trackEventAction(data: data, action: .update)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackItemTransferCreation(transferId: String) throws {
        let data = self.createJson(id: transferId, prefix: "transfer")

        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackItemTransferAction(data: data, action: .create)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackItemTransferUpdate(transferId: String) throws {
        let data = self.createJson(id: transferId, prefix: "transfer")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackItemTransferAction(data: data, action: .updateStatus)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackLogin(accountId: String) throws {
        let data = self.createJson(id: accountId, prefix: "auth", idSufix: "account_id")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackAccountAuthAction(data: data, action: .login)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackLogout(accountId: String) throws {
        let data = self.createJson(id: accountId, prefix: "auth", idSufix: "account_id")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackAccountAuthAction(data: data, action: .logout)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackPasswordRecovery(accountEmail: String) throws {
        let data = self.createJson(id: accountEmail, prefix: "pass_recovery", idSufix: "email")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackPasswordRecoveryAction(data: data, action: .recovery)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackPasswordReset(accountEmail: String) throws {
        let data = self.createJson(id: accountEmail, prefix: "pass_recovery", idSufix: "email")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackPasswordRecoveryAction(data: data, action: .reset)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackSaleCreation(saleId: String) throws {
        let data = self.createJson(id: saleId, prefix: "sale")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackSaleAction(data: data, action: .create)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
    }
    
    public func trackSaleUpdate(saleId: String) throws {
        let data = self.createJson(id: saleId, prefix: "sale")
        
        try self.verifyResource()
        
        do {
            try self.inspetorResource!.trackSaleAction(data: data, action: .update)
        } catch TrackerException.internalError(let message) {
            print("InspetorLog: \(message)")
        } catch {
            print("InspetorLog: An error occured")
        }
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
    
    private func createJson(id: String, prefix: String, idSufix: String = "id", timestampSufix: String = "timestamp") -> Dictionary<String, String> {
        var dict = [String: String]()
        
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
