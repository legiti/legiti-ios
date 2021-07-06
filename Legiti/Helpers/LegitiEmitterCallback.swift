import Foundation
import SnowplowTracker

internal class LegitiEmitterCallback: NSObject, RequestCallback {
    
    func onSuccess(withCount successCount: Int) {
        var activity = "activity"
        var wasOrWere = "was"
        
        if successCount > 1 {
            activity = "activities"
            wasOrWere = "were"
        }
        
        print("LegitiLog: \(successCount) \(activity) \(wasOrWere) sent to Legiti")
        
    }
    
    func onFailure(withCount failureCount: Int, successCount: Int) {
        var activity = "activity"
        var wasOrWere = "was"
        
        if successCount > 1 {
            activity = "activities"
            wasOrWere = "were"
        }
        
        print("LegitiLog: \(successCount) \(activity) \(wasOrWere) not sent to Legiti, because an error happend")
    }
    
    
}
