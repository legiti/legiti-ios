import XCTest
@testable import Inspetor

class LegitiUnitTests: XCTestCase {
    
    // These tokens were created using the JWT website. The "middle part" is `{"principalId": "Legiti_test"}`
    private static let sandboxAuthToken: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcmluY2lwYWxJZCI6Imluc3BldG9yX3Rlc3Rfc2FuZGJveCJ9.jo0VeV2k8i2TWP6Us9WSokHhEyVIBOa6hrxGqbDADt8"
    private static let authToken: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcmluY2lwYWxJZCI6Imluc3BldG9yX3Rlc3QifQ.cJimBzTsFCC5LMurLelIax_-0ejXYEOZdYIL7Q3GEEQ"

    private func setUpTracker() {
        do {
            try Legiti.sharedInstance().setup(authToken: LegitiUnitTests.sandboxAuthToken, legitiDevEnv: true)
        } catch {
            fatalError("Error when initializing the tracker")
        }
    }
    
    func testIfThrowsExceptionWhenCallUserCreationWithoutConfig() {
        let LegitiResource = Legiti.sharedInstance()
        XCTAssertThrowsError(try LegitiResource.trackUserCreation(userId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallUserUpdateWithoutConfig() {
        let LegitiResource = Legiti.sharedInstance()
        XCTAssertThrowsError(try LegitiResource.trackUserUpdate(userId: "123"))
    }
    
    
    func testIfThrowsExceptionWhenCallLoginWithoutConfig() {
        let LegitiResource = Legiti.sharedInstance()
        XCTAssertThrowsError(try LegitiResource.trackLogin(userEmail: "login@email.com", userId: nil))
    }
    
    func testIfThrowsExceptionWhenCallLogoutWithoutConfig() {
        let LegitiResource = Legiti.sharedInstance()
        XCTAssertThrowsError(try LegitiResource.trackLogout(userEmail: "logout@email.com", userId: nil))
    }
    
    func testIfThrowsExceptionWhenCallSaleCreationWithoutConfig() {
        let LegitiResource = Legiti.sharedInstance()
        XCTAssertThrowsError(try LegitiResource.trackOrderCreation(orderId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallPasswordResetWithoutConfig() {
        let LegitiResource = Legiti.sharedInstance()
        XCTAssertThrowsError(try LegitiResource.trackPasswordReset(userId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallPasswordRecoveryWithoutConfig() {
        let LegitiResource = Legiti.sharedInstance()
        XCTAssertThrowsError(try LegitiResource.trackPasswordRecovery(userEmail: "recovery@email.com"))
    }
    
    func testIfThrowsExceptionWhenSetupWithEmptyToken() {
        XCTAssertThrowsError(try Legiti.sharedInstance().setup(authToken: ""))
    }

    func testIfThrowsExceptionWhenAuthTokenIsMissingPart() {
        let invalidAuthToken = LegitiUnitTests.authToken.split(separator: ".")[0...1].joined(separator: ".")
        XCTAssertThrowsError(try Legiti.sharedInstance().setup(authToken: invalidAuthToken))
    }

    func testIfThrowsExceptionWhenAuthTokenMissingPrincipalId() {
        let splittedToken = LegitiUnitTests.authToken.split(separator: ".")
        let middlePartToEncode = "{\"missing_principal_id\": \"this_is_not_valid\"}"
        
        if let data = middlePartToEncode.data(using: .utf8) {
            let invalidTokenArray = [String(splittedToken[0]), data.base64EncodedString(), String(splittedToken[2])]
            let invalidAuthToken = invalidTokenArray.joined(separator: ".")
            XCTAssertThrowsError(try Legiti.sharedInstance().setup(authToken: invalidAuthToken))
        }
    }
    
}
