//
//  Actions.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 12/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class Actions {
    
    //MARK: accountActions
    enum accountActions: String {
        case create = "account_create"
        case update = "account_update"
        case delete = "account_delete"
    }

    //MARK: eventActions
    enum eventAction: String {
        case create = "event_create"
        case update = "event_update"
        case delete = "event_delete"
    }

    //MARK: authActions
    enum authActions: String {
        case login = "account_login"
        case logout = "account_logout"
    }

    //MARK: passRecoveryActions
    enum passRecoveryActions: String {
        case reset = "password_reset"
        case recovery = "password_recovery"
    }

    //MARK: saleActions
    enum saleActions: String {
        case create = "sale_create"
        case update = "sale_update"
    }

    //MARK: transferActions
    enum transferActions: String {
        case create = "transfer_create"
        case updateStatus = "transfer_update_status"
    }

}
