import Foundation
import INTULocationManager
import SnowplowTracker

class LegitiGeoLocation {
    
    //MARK: Properties
    internal static let sharedInstance: LegitiGeoLocation = LegitiGeoLocation()
    internal var currentLocation: CLLocation?
    
    //MARK: Init
    init() {
        if currentLocation == nil {
            self.getGeoLocation()
        }
    }
    
    //MARK: INUITLocationManager
    private func getGeoLocation() {
        if self.checkPermisionGeoLocation() {
            self.requestLocation()
        }
    }
    
    private func requestLocation() {
        let locationManager = INTULocationManager.sharedInstance()
        
        locationManager.requestLocation(withDesiredAccuracy: .block, timeout: 5.0, delayUntilAuthorized: false, block: {
            (currentLocation, achivedAcccuaracy, status) in
            if status == .success {
                self.currentLocation = currentLocation
            } else if status == .timedOut {
                if achivedAcccuaracy != .none {
                    self.currentLocation = currentLocation
                }
            }
        })
    }
    
    private func checkPermisionGeoLocation() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            @unknown default:
                return false
            }
        }
        return false
    }
    
    //MARK: getGeoLocationSubject
    internal func getLocationSubject() -> SPSubject {
        let subject = SnowplowManager.sharedInstance.getSubject()
        
        if currentLocation == nil {
            return subject
        }
        
        subject.setGeoLatitude(Float(currentLocation!.coordinate.latitude))
        subject.setGeoLongitude(Float(currentLocation!.coordinate.longitude))
        subject.setGeoAltitude(Float(currentLocation!.altitude))
        subject.setGeoTimestamp(NSNumber(value: Int(currentLocation!.timestamp.timeIntervalSince1970 * 1000)))
        subject.setGeoLatitudeLongitudeAccuracy(Float(currentLocation!.horizontalAccuracy))
        subject.setGeoAltitudeAccuracy(Float(currentLocation!.verticalAccuracy))
        subject.setGeoBearing(Float(currentLocation!.course))
        subject.setGeoSpeed(Float(currentLocation!.speed))
        subject.setTimezone(TimeZone.current.identifier)
        
        return subject
    }
    
}
