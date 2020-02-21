import Foundation

class Actions {
    
    //MARK: userActions
    enum userActions: String {
        case create = "user_create"
        case update = "user_update"
    }

    //MARK: authActions
    enum authActions: String {
        case login = "user_login"
        case logout = "user_logout"
    }

    //MARK: passwordActions
    enum passwordActions: String {
        case reset = "password_reset"
        case recovery = "password_recovery"
    }

    //MARK: orderActions
    enum orderActions: String {
        case create = "order_create"
    }

}
