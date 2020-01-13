//
//  InspetorUnitTests.swift
//  InspetorUnitTests
//
//  Created by Lourenço Biselli on 17/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import XCTest
@testable import Inspetor

class InspetorUnitTests: XCTestCase {
    
    // These tokens were created using the JWT website. The "middle part" is `{"principalId": "inspetor_test"}`
    private static let sandboxAuthToken: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcmluY2lwYWxJZCI6Imluc3BldG9yX3Rlc3Rfc2FuZGJveCJ9.jo0VeV2k8i2TWP6Us9WSokHhEyVIBOa6hrxGqbDADt8"
    private static let authToken: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcmluY2lwYWxJZCI6Imluc3BldG9yX3Rlc3QifQ.cJimBzTsFCC5LMurLelIax_-0ejXYEOZdYIL7Q3GEEQ"

    private func setUpTracker() {
        do {
            try Inspetor.sharedInstance().setup(authToken: InspetorUnitTests.sandboxAuthToken, inspetorDevEnv: true)
        } catch {
            fatalError("Error when initializing the tracker")
        }
    }
    
    func testIfThrowsExceptionWhenCallAccountCreationWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackAccountCreation(accountId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallAccountUpdateWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackAccountUpdate(accountId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallAccountDeletionWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackAccountDeletion(accountId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallLoginWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackLogin(accountEmail: "login@email.com", accountId: nil))
    }
    
    func testIfThrowsExceptionWhenCallLogoutWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackLogout(accountEmail: "logout@email.com", accountId: nil))
    }
    
    func testIfThrowsExceptionWhenCallEventCreationWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackEventCreation(eventId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallEventUpdateWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackEventUpdate(eventId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallEventDeletionWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackEventDeletion(eventId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallSaleCreationWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackSaleCreation(saleId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallSaleUpdateWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackSaleUpdate(saleId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallPasswordResetWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackPasswordReset(accountEmail: "reset@email.com"))
    }
    
    func testIfThrowsExceptionWhenCallPasswordRecoveryWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackPasswordRecovery(accountEmail: "recovery@email.com"))
    }
    
    func testIfThrowsExceptionWhenCallTransferCreationWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackItemTransferCreation(transferId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallTransferUpdateWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance()
        XCTAssertThrowsError(try inspetorResource.trackItemTransferUpdate(transferId: "123"))
    }
    
    func testIfThrowsExceptionWhenSetupWithEmptyToken() {
        XCTAssertThrowsError(try Inspetor.sharedInstance().setup(authToken: ""))
    }

    func testIfThrowsExceptionWhenAuthTokenIsMissingPart() {
        let invalidAuthToken = InspetorUnitTests.authToken.split(separator: ".")[0...1].joined(separator: ".")
        XCTAssertThrowsError(try Inspetor.sharedInstance().setup(authToken: invalidAuthToken))
    }

    func testIfThrowsExceptionWhenAuthTokenMissingPrincipalId() {
        let splittedToken = InspetorUnitTests.authToken.split(separator: ".")
        let middlePartToEncode = "{\"missing_principal_id\": \"this_is_not_valid\"}"
        
        if let data = middlePartToEncode.data(using: .utf8) {
            let invalidTokenArray = [String(splittedToken[0]), data.base64EncodedString(), String(splittedToken[2])]
            let invalidAuthToken = invalidTokenArray.joined(separator: ".")
            XCTAssertThrowsError(try Inspetor.sharedInstance().setup(authToken: invalidAuthToken))
        }
    }
    
}
