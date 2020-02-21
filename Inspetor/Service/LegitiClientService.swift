import Foundation

protocol LegitiClientService {

    func trackPageView(pageTitle: String) throws

    func trackUserCreation(userId: String) throws

    func trackUserUpdate(userId: String) throws

    func trackLogin(userEmail: String, userId: String?) throws

    func trackLogout(userEmail: String, userId: String?) throws

   func trackPasswordRecovery(userEmail: String) throws

    func trackPasswordReset(userId: String) throws

    func trackOrderCreation(orderId: String) throws
}
