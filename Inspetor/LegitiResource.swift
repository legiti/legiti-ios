import Foundation
import SnowplowTracker
import INTULocationManager

class LegitiResource: NSObject, LegitiResourceService {
    
    //MARK: Properties
    internal var legitiConfig: LegitiConfig
    internal var tracker: SPTracker?
    private var legitiGeoLocation: InspetorGeoLocation = InspetorGeoLocation.sharedInstance
    
    //MARK: init
    init(legitiConfig: LegitiConfig) {
        self.legitiConfig = legitiConfig
        super.init()
        //Get the Snowplow tracker through our SnoplowManager Class
        SnowplowManager.sharedInstance.inspetorConfig = self.legitiConfig
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
        
        let sdj = SPSelfDescribingJson(schema: schema, andData: data)
        
        let actionContext = SPSelfDescribingJson(
            schema: LegitiDependencies.actionContextSchema,
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
        if self.legitiGeoLocation.currentLocation != nil {
            self.tracker!.setSubject(InspetorGeoLocation.sharedInstance.getLocationSubject())
            self.tracker!.trackUnstructuredEvent(unstructedEvent)
        } else {
            self.tracker!.trackUnstructuredEvent(unstructedEvent)
        }
    }
    
    private func trackEvent(screenViewEvent: SPScreenView) {
        if self.legitiGeoLocation.currentLocation != nil {
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
            schema: LegitiDependencies.fingerprintContextSchema,
            andData: (deviceContext as NSDictionary)
        )
        return fingerprintContext!
    }
    
}
