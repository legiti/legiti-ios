import Foundation

public class Legiti {
    
    private static let instance: LegitiClient = LegitiClient()
    
    public static func sharedInstance() -> LegitiClient {
        // Since it takes sometime to actualy acquirer the location
        // we are requesting as soon as the SDK is initialized
        let _ = LegitiGeoLocation.sharedInstance.getGeoLocation()
        return self.instance
    }
    
}
