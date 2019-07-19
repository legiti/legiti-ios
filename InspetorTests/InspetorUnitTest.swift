//
//  InspetorUnitTest.swift
//  InspetorTests
//
//  Created by Inspetor on 16/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import XCTest
@testable import Inspetor

class InspetorUnitTest: XCTestCase {

    private func setUpTracker() {
        let inspetorConfig: InspetorConfig = InspetorConfig(appId: "123", nameTracker: "inspetor.ios.test")
        Inspetor.sharedInstance.inspetorConfig = inspetorConfig
    }
    
    func testIfThrowsExceptionWhenCallAccountCreationWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackAccountCreation(accountId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallAccountUpdateWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackAccountUpdate(accountId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallAccountDeletionWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackAccountDeletion(accountId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallLoginWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackLogin(accountId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallLogoutWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackLogout(accountId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallEventCreationWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackEventCreation(eventId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallEventUpdateWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackEventUpdate(eventId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallEventDeletionWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackEventDeletion(eventId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallSaleCreationWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackSaleCreation(saleId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallSaleUpdateWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackSaleUpdate(saleId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallPasswordResetWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackPasswordReset(passResetEmail: "reset@email.com"))
    }
    
    func testIfThrowsExceptionWhenCallPasswordRecoveryWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackPasswordRecovery(passRecoveryEmail: "recovery@email.com"))
    }
    
    func testIfThrowsExceptionWhenCallTransferCreationWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackItemTransferCreation(transferId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallTransferUpdateWithoutConfig() {
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackItemTransferUpdate(transferId: "123"))
    }
    
    func testIfThrowsExceptionWhenCallTransferUpdateConfigEmpyString() {
        Inspetor.sharedInstance.inspetorConfig = InspetorConfig(appId: "", nameTracker: "")
        let inspetorResource = Inspetor.sharedInstance
        XCTAssertThrowsError(try inspetorResource.trackItemTransferUpdate(transferId: "123"))
    }

}
