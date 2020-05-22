import Foundation

public class LegitiClient: LegitiClientService {
    
    //MARK: Properties
    private var legitiResource: LegitiResource?
    private var legitiConfig: LegitiConfig?
    private let errorMessage9001 = "Library not configured"
    private let errorMessage9002 = "AuthToken is not valid"
    
    //MARK: setup
    public func setup(authToken: String, legitiDevEnv: Bool = false) throws {
        guard let config = LegitiConfig(authToken: authToken, legitiDevEnv: legitiDevEnv) else {
            throw TrackerException.requiredConfig(code: 9002, message: self.errorMessage9002)
        }
        
        self.legitiConfig = config
    }
    
    //MARK: trackers
    public func trackPageView(pageTitle: String) throws {
        try self.verifyResource()
        self.legitiResource!.trackPageView(pageTitle: pageTitle)
    }
    
    public func trackUserCreation(userId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: userId, prefix: "user")
        self.legitiResource!.trackUserAction(data: data, action: .create)
    }
    
    public func trackUserUpdate(userId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: userId, prefix: "user")
        self.legitiResource!.trackUserAction(data: data, action: .update)
    }
    
    public func trackLogin(userEmail: String, userId: String?) throws {
        try self.verifyResource()
        
        var data = self.createJson(id: userEmail, prefix: "auth", idSufix: "user_email")
        // Inline if for encoding data if accountId was passed
        data["auth_user_id"] = userId != nil ? self.encodeData(stringToEncode: userId!) : nil

        self.legitiResource!.currentUserId = (userId ?? "").isEmpty ? nil : userId
        
        self.legitiResource!.trackUserAuthAction(data: data, action: .login)
    }
    
    public func trackLogout(userEmail: String, userId: String?) throws {
        try self.verifyResource()
        
        var data = self.createJson(id: userEmail, prefix: "auth", idSufix: "user_email")
        // Inline if for encoding data if accountId was passed
        data["auth_user_id"] = userId != nil ? self.encodeData(stringToEncode: userId!) : nil

        self.legitiResource!.currentUserId = nil

        self.legitiResource!.trackUserAuthAction(data: data, action: .logout)
    }
    
    public func trackPasswordRecovery(userEmail: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: userEmail, prefix: "pass_recovery", idSufix: "email")
        self.legitiResource!.trackPasswordRecoveryAction(data: data, action: .recovery)
    }
    
    public func trackPasswordReset(userId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: userId, prefix: "pass_reset", idSufix: "user_id")
        self.legitiResource!.trackPasswordResetAction(data: data, action: .reset)
    }
    
    public func trackOrderCreation(orderId: String) throws {
        try self.verifyResource()
        
        let data = self.createJson(id: orderId, prefix: "order")
        self.legitiResource!.trackOrderAction(data: data, action: .create)
    }
    
    
    //MARK: Helper Functions
    private func getLegitiTimestamp() -> String {
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
    
    private func createJson(
        id: String,
        prefix: String,
        idSufix: String = "id",
        timestampSufix: String = "timestamp"
    ) -> Dictionary<String, String?> {
        var dict = [String: String?]()
        
        let idProperty = "\(prefix)_\(idSufix)"
        let timestampProperty = "\(prefix)_\(timestampSufix)"
        
        dict[idProperty] = self.encodeData(stringToEncode: id)
        dict[timestampProperty] = self.encodeData(stringToEncode: self.getLegitiTimestamp())
        
        return dict
    }
    
    private func verifyResource() throws {
        if !(self.isConfigured()) {
            throw TrackerException.requiredConfig(code: 9001, message: self.errorMessage9001)
        }
        
        if (self.legitiResource == nil) {
            self.legitiResource = LegitiResource(legitiConfig: self.legitiConfig!)
        }
    }
    
    public func isConfigured() -> Bool {
        return (self.legitiConfig == nil ? false : true)
    }
    
}
