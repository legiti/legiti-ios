import Foundation
import SnowplowTracker

class LegitiResource: NSObject, LegitiResourceService {
    
    //MARK: Properties
    internal var legitiConfig: LegitiConfig
    internal var tracker: TrackerController?
    internal var currentUserId: String? = nil
    
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
        let event = ScreenView(name: pageTitle, screenId: UUID())
        event.contexts.add(self.getFingerprintContext())
        self.tracker!.track(event)
    }
    
    internal func trackUserAction(data: Dictionary<String, String?>, action: Actions.userActions) {
        self.tracker!.track(self.createUnstructuredEvent(
            schema: LegitiDependencies.userSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ))
    }
    
    internal func trackUserAuthAction(data: Dictionary<String, String?>, action: Actions.authActions) {
        self.tracker!.track(self.createUnstructuredEvent(
            schema: LegitiDependencies.authSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ))
    }
    
    internal func trackPasswordRecoveryAction(data: Dictionary<String, String?>, action: Actions.passwordActions) {
        self.tracker!.track(self.createUnstructuredEvent(
            schema: LegitiDependencies.passRecoverySchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ))
    }
    
    internal func trackOrderAction(data: Dictionary<String, String?>, action: Actions.orderActions) {
        self.tracker!.track(self.createUnstructuredEvent(
            schema: LegitiDependencies.orderSchema,
            data: (data as NSDictionary),
            action: action.rawValue
        ))
    }
    
    //MARK: Helper Functions        
    private func createUnstructuredEvent(schema: String, data: NSDictionary, action: String) -> SelfDescribing {
        let contextData: NSDictionary = ["action": action]
        let event = SelfDescribing(eventData: SelfDescribingJson(schema: schema, andData: data))
        let actionContext = SelfDescribingJson(schema: LegitiDependencies.actionContextSchema, andData: contextData)
        
        event.contexts.add(actionContext!)
        event.contexts.add(self.getFingerprintContext())

        return event
    }
    
    //MARK: FingerprintContext
    private func getFingerprintContext() -> SelfDescribingJson {
        var deviceContext = LegitiDeviceData().getDeviceData()
        deviceContext["logged_user_id"] = self.currentUserId ?? nil as Any?

        return SelfDescribingJson(
            schema: LegitiDependencies.fingerprintContextSchema,
            andData: (deviceContext as NSDictionary)
        )
    }
    
}
