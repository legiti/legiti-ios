import Foundation
import SnowplowTracker
import INTULocationManager

class LegitiResource: NSObject, LegitiResourceService {
    
    //MARK: Properties
    internal var legitiConfig: LegitiConfig
    internal var tracker: SPTracker?
    internal var currentUserId: String? = nil
    private var legitiGeoLocation: LegitiGeoLocation = LegitiGeoLocation.sharedInstance
    
    //MARK: init
    init(legitiConfig: LegitiConfig) {
        self.legitiConfig = legitiConfig
        super.init()
        //Get the Snowplow tracker through our SnoplowManager Class
        SnowplowManager.sharedInstance.legitiConfig = self.legitiConfig
        self.tracker = SnowplowManager.sharedInstance.getTracker()
    }
        
    //MARK: TrackActions
    internal func trackPageView(pageTitle: String) {
        
        // Although we are using pageView as the name for this function we are using the snowplow
        // screenView function. We are doing this since we want to maintain function name consistency
        // in all of our frontend libraries
        let screenViewEvent = SPScreenView.build({ (builder: SPScreenViewBuilder?) -> Void in
            builder!.setName(pageTitle)
            if let fingerprintContext = self.getFingerprintContext() {
                builder!.setContexts(NSMutableArray(array: [fingerprintContext]))
            }
        })
        
        self.trackEvent(screenViewEvent: screenViewEvent)
    }
    
    internal func trackUserAction(data: Dictionary<String, String?>, action: Actions.userActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: LegitiDependencies.userSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("LegitiLog: An error occured")
            return
        }
                
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackUserAuthAction(data: Dictionary<String, String?>, action: Actions.authActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: LegitiDependencies.authSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
           print("LegitiLog: An error occured")
           return
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackPasswordRecoveryAction(data: Dictionary<String, String?>, action: Actions.passwordActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: LegitiDependencies.passRecoverySchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("LegitiLog: An error occured")
            return
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackPasswordResetAction(data: Dictionary<String, String?>, action: Actions.passwordActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: LegitiDependencies.passResetSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("LegitiLog: An error occured")
            return
        }
        
        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    internal func trackOrderAction(data: Dictionary<String, String?>, action: Actions.orderActions) {
        
        guard let unstructedEvent = self.createUnstructuredEvent(
            schema: LegitiDependencies.orderSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ) else {
            print("LegitiLog: An error occured")
            return
        }

        self.trackEvent(unstructedEvent: unstructedEvent)
    }
    
    //MARK: Helper Functions        
    private func createUnstructuredEvent(schema: String, data: NSDictionary, action: String) -> SPUnstructured? {
        
        let contextData: NSDictionary = ["action": action]
        
        guard let sdj = SPSelfDescribingJson(schema: schema, andData: data) else { return nil }
        
        let actionContext = SPSelfDescribingJson(
            schema: LegitiDependencies.actionContextSchema,
            andData: contextData
        )
        
        let unstructedEvent = SPUnstructured.build({ (builder: SPUnstructuredBuilder?) -> Void in
            builder!.setEventData(sdj)
            
            var contextArray = [actionContext!]
            if let deviceFingerprint = self.getFingerprintContext() {
                contextArray.append(deviceFingerprint)
            }
            builder!.setContexts(NSMutableArray(array: NSMutableArray(array: contextArray)))
        })
        
        return unstructedEvent
    }
    
    
    //MARK: TrackEvent
    private func trackEvent(unstructedEvent: SPUnstructured) {
        if self.legitiGeoLocation.currentLocation != nil {
            self.tracker!.setSubject(self.legitiGeoLocation.getLocationSubject())
            self.tracker!.trackUnstructuredEvent(unstructedEvent)
        } else {
            self.tracker!.trackUnstructuredEvent(unstructedEvent)
        }
    }
    
    private func trackEvent(screenViewEvent: SPScreenView) {
        if self.legitiGeoLocation.currentLocation != nil {
            self.tracker!.setSubject(self.legitiGeoLocation.getLocationSubject())
            self.tracker!.trackScreenViewEvent(screenViewEvent)
        } else {
            self.tracker!.trackScreenViewEvent(screenViewEvent)
        }
    }
    
    
    //MARK: FingerprintContext
    private func getFingerprintContext() -> SPSelfDescribingJson? {
        var deviceContext = LegitiDeviceData().getDeviceData()
        deviceContext["logged_user_id"] = self.currentUserId ?? nil as Any?

        let fingerprintContext = SPSelfDescribingJson(
            schema: LegitiDependencies.fingerprintContextSchema,
            andData: (deviceContext as NSDictionary)
        )
        return fingerprintContext!
    }
    
}
