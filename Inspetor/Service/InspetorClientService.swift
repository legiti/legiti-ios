//
// InspetorClientService.swift
//
//

import Foundation

protocol InspetorClientService {

    /**
     Send account creation data to Inspetor
     - parameter accountId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackAccountCreation(accountId: String) throws

    /**
     Send account deletion data to Inspetor
     - parameter accountId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackAccountDeletion(accountId: String) throws

    /**
     Send account update data to Inspetor
     - parameter accountId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackAccountUpdate(accountId: String) throws

    /**
     Send event creation data to Inspetor
     - parameter eventId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackEventCreation(eventId: String) throws

    /**
     Send event deletion data to Inspetor
     - parameter eventId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackEventDeletion(eventId: String) throws

    /**
     Send event update data to Inspetor
     - parameter eventId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackEventUpdate(eventId: String) throws

    /**
     Send item transfer creation data to Inspetor
     - parameter transferId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackItemTransferCreation(transferId: String) throws

    /**
     Send item transfer update data to Inspetor
     - parameter transferId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackItemTransferUpdate(transferId: String) throws

    /**
     Send account login data to Inspetor
     - parameter accountId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackLogin(accountEmail: String) throws

    /**
     Send account logout data to Inspetor
     - parameter accountId: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackLogout(accountEmail: String) throws

    /**
     Send password recovery data to Inspetor
     - parameter passRecoveryEmail: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
   func trackPasswordRecovery(accountEmail: String) throws

    /**
     Send password reset data to Inspetor
     - parameter passResetEmail: (query)
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackPasswordReset(accountEmail: String) throws

    /**
     Send sale creation data to Inspetor
     - parameter sale: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackSaleCreation(saleId: String) throws

    /**
     Send sale update data to Inspetor
     - parameter sale: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    func trackSaleUpdate(saleId: String) throws

}
