import Foundation
import SnowplowTracker
import CoreLocation

internal class SnowplowManager {
    
    //MARK: Properties
    private let emitterCallback: LegitiEmitterCallback = LegitiEmitterCallback()
    private var tracker: TrackerController?
    internal var legitiConfig: LegitiConfig?
    
    private static let defaultTrackerName: String = "legiti.ios.tracker"
    internal static var sharedInstance: SnowplowManager = SnowplowManager()
    
    
    //MARK: Setup Tracker
    private func setupTracker(legitiConfig: LegitiConfig) -> TrackerController {
        let trackerConfiguration = TrackerConfiguration()
            .appId(legitiConfig.authToken)
            .base64Encoding(LegitiDependencies.defaultBase64Option)
            .devicePlatform(.mobile)
            .sessionContext(true)
            .platformContext(true)
            .geoLocationContext(LegitiGeoLocation.sharedInstance.checkPermisionGeoLocation())
            .exceptionAutotracking(false)
            .installAutotracking(false)
            .screenViewAutotracking(false)
    
        let networkConfiguration = NetworkConfiguration(
            endpoint: LegitiDependencies.defaultCollectorURL,
            method: LegitiDependencies.defaultHttpMethodType
        ).customPostPath(legitiConfig.legitiDevEnv ? LegitiDependencies.stagingPostPath : LegitiDependencies.prodPostPath)

        let emitterConfiguration = EmitterConfiguration()
            .bufferOption(BufferOption.single)
            .requestCallback(self.emitterCallback)
        
    
        return Snowplow.createTracker(
            namespace: SnowplowManager.defaultTrackerName,
            network: networkConfiguration,
            configurations: [trackerConfiguration, emitterConfiguration, SubjectConfiguration()]
        )
    }
    
    //MARK: getTracker
    internal func getTracker() -> TrackerController {
        if self.tracker == nil {
            if self.legitiConfig == nil {
                fatalError("Error in the Legiti Framework")
            }
            self.tracker = setupTracker(legitiConfig: self.legitiConfig!)
        }
        return self.tracker!
    }
    
    //MARK: setGeoLocationSubject
    internal func setGeoLocationSubject(location: CLLocation) {
        guard let tracker = self.tracker else {
            // We are trying to update the geoLocation data before the tracker is initialized
            return
        }
        guard let subject = tracker.subject else {
            // Making sure subject is not nil
            return
        }
        
        subject.geoLatitude = NSNumber(value: location.coordinate.latitude)
        subject.geoLongitude = NSNumber(value: location.coordinate.longitude)
        subject.geoLatitudeLongitudeAccuracy = NSNumber(value: location.horizontalAccuracy)
        subject.geoAltitude = NSNumber(value: location.altitude)
        subject.geoTimestamp = NSNumber(value: Int(location.timestamp.timeIntervalSince1970 * 1000))
        subject.geoAltitudeAccuracy = NSNumber(value: location.verticalAccuracy)
        subject.geoSpeed = NSNumber(value: location.speed)
        subject.geoBearing = NSNumber(value: location.course)
        subject.timezone = TimeZone.current.identifier
    }
    
}
