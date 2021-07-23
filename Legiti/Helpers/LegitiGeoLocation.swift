import Foundation
import SnowplowTracker
import CoreLocation

class LegitiGeoLocation: NSObject, CLLocationManagerDelegate {
    
    //MARK: Properties
    internal static let sharedInstance: LegitiGeoLocation = LegitiGeoLocation()
    internal var currentLocation: CLLocation?
    internal var locationManager: CLLocationManager?
    
    //MARK: Init
    override init() {
        super.init()

        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        locationManager.delegate = self
    }
    
    //MARK: INUITLocationManager
    internal func getGeoLocation() {
        if self.checkPermisionGeoLocation() {
            self.requestLocation()
        }
    }
    
    private func requestLocation() {
        self.locationManager?.requestLocation()
    }
    
    internal func checkPermisionGeoLocation() -> Bool {
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

    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.currentLocation = location
        SnowplowManager.sharedInstance.setGeoLocationSubject(location: location)
        manager.stopUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
    
}
