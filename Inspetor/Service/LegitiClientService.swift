//
// LegitiClientService.swift
//
//

import Foundation

protocol LegitiClientService {

    func trackPageView(pageTitle: String) throws
    /**
     Send account creation data to Legiti
     - parameter userId: (string)
     */
    func trackUserCreation(userId: String) throws

    /**
     Send account update data to Legiti
     - parameter userId: (string)
     */
    func trackUserUpdate(userId: String) throws

    /**
     Send account login data to Legiti
     - parameter userId: (string)
     - parameter userEmail: (string)
     */
    func trackLogin(userEmail: String, userId: String?) throws

    /**
     Send account logout data to Legiti
     - parameter userEmail: (string)
     - parameter userId: (string)
     */
    func trackLogout(userEmail: String, userId: String?) throws

    /**
     Send password recovery data to Legiti
     - parameter userEmail: (string)
     */
   func trackPasswordRecovery(userEmail: String) throws

    /**
     Send password reset data to Legiti
     - parameter userId: (string)
     */
    func trackPasswordReset(userId: String) throws

    /**
     Send sale creation data to Legiti
     - parameter orderId: (string)
     */
    func trackOrderCreation(orderId: String) throws
}
