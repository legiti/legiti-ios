//
// InspetorResourceService.swift
//
//

import Foundation

protocol InspetorResourceService {
    
    func trackPageView(pageTitle: String) throws
    /**
     Send account data to Inspetor
     - parameter data: (query)       - parameter action: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackAccountAction(data: Dictionary<String, String?>, action: Actions.accountActions) throws

    /**
     Send auth data to Inspetor
     - parameter data: (query)       - parameter action: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackAccountAuthAction(data: Dictionary<String, String?>, action: Actions.authActions) throws

    /**
     Send event data to Inspetor
     - parameter data: (query)       - parameter action: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackEventAction(data: Dictionary<String, String?>, action: Actions.eventAction) throws

    /**
     Send item transfer data to Inspetor
     - parameter data: (query)       - parameter action: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackItemTransferAction(data: Dictionary<String, String?>, action: Actions.transferActions) throws

    /**
     Send pass recovery data to Inspetor
     - parameter data: (query)       - parameter action: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackPasswordRecoveryAction(data: Dictionary<String, String?>, action: Actions.passRecoveryActions) throws


    /**
     Send Sale data to Inspetor
     - parameter data: (query)       - parameter action: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackSaleAction(data: Dictionary<String, String?>, action: Actions.saleActions) throws

}
