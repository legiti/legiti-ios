//
//  InspetorConfig.swift
//  InspetorSwiftFramework
//
//  Created by Pearson Henri on 4/1/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

struct InspetorDependencies {
    
    static let defaultBase64Option: Bool = true
    static let defaultCollectorHost: String = "analytics-dev.useinspetor.com"
    static let defaultHttpMethodType: SPRequestOptions = SPRequestOptions.get
    static let defaultProtocolType: SPProtocol = SPProtocol.https
    
    // Schema versions
    static let inspetorAuthSchema: String = "iglu:com.inspetor/inspetor_auth_frontend/jsonschema/1-0-0"
    static let inspetorPassRecoverySchema: String = "iglu:com.inspetor/inspetor_pass_recovery_frontend/jsonschema/1-0-0"
    static let inspetorSaleSchema: String = "iglu:com.inspetor/inspetor_sale_frontend/jsonschema/1-0-0"
    static let inspetorItemTransferSchema: String = "iglu:com.inspetor/inspetor_transfer_frontend/jsonschema/1-0-0"
    static let inspetorAccountSchema: String = "iglu:com.inspetor/inspetor_account_frontend/jsonschema/1-0-0"
    static let inspetorEventSchema: String = "iglu:com.inspetor/inspetor_event_frontend/jsonschema/1-0-0"
    static let inspetorContextSchema: String = "iglu:com.inspetor/inspetor_context/jsonschema/1-0-0"

}
