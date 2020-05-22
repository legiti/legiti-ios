import Foundation
import SnowplowTracker

internal class SnowplowManager {
    
    //MARK: Properties
    private let emitterCallback: LegitiEmitterCallback = LegitiEmitterCallback()
    private var tracker: SPTracker?
    internal var legitiConfig: LegitiConfig?
    
    private static let defaultTrackerName: String = "legiti.ios.tracker"
    internal static var sharedInstance: SnowplowManager = SnowplowManager()
    
    //MARK: Setup Tracker
    private func setupTracker(legitiConfig: LegitiConfig) -> SPTracker? {
        let postPath = legitiConfig.legitiDevEnv ? LegitiDependencies.stagingPostPath : LegitiDependencies.prodPostPath

        guard let emitter = SPEmitter.build({ (builder : SPEmitterBuilder?) -> Void in
            builder!.setCustomPostPath(postPath)
            builder!.setUrlEndpoint(LegitiDependencies.defaultCollectorURL)
            builder!.setHttpMethod(LegitiDependencies.defaultHttpMethodType)
            builder!.setProtocol(LegitiDependencies.defaultProtocolType)
            builder!.setCallback(self.emitterCallback)
            builder!.setEmitThreadPoolSize(1)
            builder!.setByteLimitPost(50)
        }) else {
            return nil
        }
        
        let subject = SPSubject(platformContext: true, andGeoContext: true)
        subject!.setTimezone(TimeZone.current.identifier)
        
        guard let newTracker = SPTracker.build({ (builder: SPTrackerBuilder?) -> Void in
            builder!.setEmitter(emitter)
            builder!.setAppId(legitiConfig.authToken)
            builder!.setTrackerNamespace(SnowplowManager.defaultTrackerName)
            builder!.setBase64Encoded(LegitiDependencies.defaultBase64Option)
            builder!.setApplicationContext(true)
            builder!.setSessionContext(true)
            builder!.setSubject(subject)
        }) else {
            return nil
        }
        
        return newTracker
    }
    
    //MARK: getTracker
    internal func getTracker() -> SPTracker {
        
        if self.tracker == nil {
            if self.legitiConfig == nil {
                fatalError("Error in the Legiti Framework")
            }
            self.tracker = setupTracker(legitiConfig: self.legitiConfig!)
        }
        
        return self.tracker!
    }
    
    internal func getSubject() -> SPSubject {
        return SPSubject(platformContext: true, andGeoContext: true)
    }
}
