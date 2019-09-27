//
//  InspetorConfig.swift
//  InspetorSwiftFramework
//
//  Created by Pearson Henri on 4/1/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

struct InspetorConfig {
    static let DEFAULT_BASE64_OPTION: Bool = true
    static let DEFAULT_COLLECTOR_URI: String = "heimdall-prod.inspcdn.net"
    static let DEFAULT_HTTP_METHOD_TYPE: SPRequestOptions = SPRequestOptions.get
    static let DEFAULT_PROTOCOL_TYPE: SPProtocol = SPProtocol.https
    static let DEFAULT_INSPETOR_TRACKER_NAME_SEPARATOR: Character = "."
    
    // Schema versions
    static let FRONTEND_PAY_ORDER_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_pay_order/jsonschema/1-0-0"
    static let FRONTEND_CANCEL_ORDER_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_cancel_order/jsonschema/1-0-0"
    static let FRONTEND_CREATE_ORDER_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_create_order/jsonschema/1-0-0"
    static let FRONTEND_TICKET_TRANSFER_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_ticket_transfer/jsonschema/1-0-1"
    static let FRONTEND_CHANGE_PASSWORD_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_change_password/jsonschema/1-0-1"
    static let FRONTEND_ACCOUNT_UPDATE_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_account_update/jsonschema/1-0-1"
    static let FRONTEND_ACCOUNT_CREATION_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_account_creation/jsonschema/1-0-1"
    static let FRONTEND_LOGIN_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_login/jsonschema/1-0-1"
    static let FRONTEND_LOGOUT_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_logout/jsonschema/1-0-1"
    static let FRONTEND_RECOVER_PASSWORD_SCHEMA_VERSION: String = "iglu:com.inspetor/frontend_recover_password/jsonschema/1-0-2"
}
