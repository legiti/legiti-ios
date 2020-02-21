import Foundation

protocol LegitiResourceService {
    
    func trackPageView(pageTitle: String) throws

    func trackUserAction(data: Dictionary<String, String?>, action: Actions.userActions) throws

    func trackUserAuthAction(data: Dictionary<String, String?>, action: Actions.authActions) throws

    func trackPasswordRecoveryAction(data: Dictionary<String, String?>, action: Actions.passwordActions) throws

    func trackPasswordResetAction(data: Dictionary<String, String?>, action: Actions.passwordActions) throws

    func trackOrderAction(data: Dictionary<String, String?>, action: Actions.orderActions) throws

}
