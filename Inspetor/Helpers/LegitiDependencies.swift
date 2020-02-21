import Foundation
import SnowplowTracker

struct LegitiDependencies {
    
    static let defaultBase64Option: Bool = true
    static let defaultCollectorURL: String = "heimdall-staging.lgtcdn.net/"
    static let stagingPostPath: String = "post-staging"
    static let prodPostPath: String = "post"
    static let defaultHttpMethodType: SPRequestOptions = SPRequestOptions.post
    static let defaultProtocolType: SPProtocol = SPProtocol.https
    
    // Schema versions
    static let authSchema: String = "iglu:com.legiti/legiti_auth_frontend/jsonschema/1-0-0"
    static let passRecoverySchema: String = "iglu:com.legiti/legiti_pass_recovery_frontend/jsonschema/1-0-0"
    static let passResetSchema: String = "iglu:com.legiti/legiti_pass_reset_frontend/jsonschema/1-0-0"
    static let orderSchema: String = "iglu:com.legiti/legiti_order_frontend/jsonschema/1-0-0"
    static let userSchema: String = "iglu:com.legiti/legiti_user_frontend/jsonschema/1-0-0"
    static let actionContextSchema: String = "iglu:com.legiti/legiti_context_frontend/jsonschema/1-0-0"
    static let fingerprintContextSchema: String = "iglu:com.legiti/legiti_fingerprint_frontend/jsonschema/1-0-0"

}
