//
//  InspetorDependencies.swift
//  Inspetor
//
//  Created by Lourenço Biselli on 26/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

struct InspetorDependencies {
    
    static let defaultBase64Option: Bool = true
    static let defaultCollectorURL: String = "ppt.useinspetor.com/"
    //static let defaultCollectorURL: String = "ho18jk6jvh.execute-api.sa-east-1.amazonaws.com/staging/"
    //static let defaultCollectorURL: String = "localhost:3000/"
    static let stagingPostPath: String = "post-staging"
    static let prodPostPath: String = "post"
    static let defaultHttpMethodType: SPRequestOptions = SPRequestOptions.post
    static let defaultProtocolType: SPProtocol = SPProtocol.https
    //static let defaultProtocolType: SPProtocol = SPProtocol.http
    
    // Schema versions
    static let inspetorAuthSchema: String = "iglu:com.inspetor/inspetor_auth_frontend/jsonschema/1-0-3"
    static let inspetorPassRecoverySchema: String = "iglu:com.inspetor/inspetor_pass_recovery_frontend/jsonschema/1-0-0"
    static let inspetorSaleSchema: String = "iglu:com.inspetor/inspetor_sale_frontend/jsonschema/1-0-0"
    static let inspetorItemTransferSchema: String = "iglu:com.inspetor/inspetor_transfer_frontend/jsonschema/1-0-0"
    static let inspetorAccountSchema: String = "iglu:com.inspetor/inspetor_account_frontend/jsonschema/1-0-0"
    static let inspetorEventSchema: String = "iglu:com.inspetor/inspetor_event_frontend/jsonschema/1-0-0"
    static let inspetorActionContextSchema: String = "iglu:com.inspetor/inspetor_context/jsonschema/1-0-0"
    static let inspetorFingerprintContextSchema: String = "iglu:com.inspetor/inspetor_fingerprint_frontend/jsonschema/1-0-2"

}
