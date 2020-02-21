import Foundation

public class Legiti {
    
    private static let instance: LegitiClient = LegitiClient()
    
    public static func sharedInstance() -> LegitiClient {
        let _ = InspetorGeoLocation.sharedInstance
        return self.instance
    }
    
}
