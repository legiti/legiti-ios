//
//  InspetorSwiftFrameworkTests.swift
//  InspetorSwiftFrameworkTests
//
//  Created by Pearson Henri on 3/28/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import XCTest
@testable import InspetorSwiftFramework

class InspetorSwiftFrameworkTests: XCTestCase {
    var inspetor: InspetorResource = InspetorResource()

    let UNIT_TEST_DEFAULT_TRACKER_NAME = "inspetor.test-tracker"
    let UNIT_TEST_DEFAULT_APP_ID = "0123456789"

    override func setUp() {
        self.inspetor.setup(trackerName: UNIT_TEST_DEFAULT_TRACKER_NAME, appId: UNIT_TEST_DEFAULT_APP_ID)
    }

    func testVerifySetup() {
        let inspetorTestVerifySetup = InspetorResource()
        XCTAssertFalse(inspetorTestVerifySetup.verifySetup())
        
        inspetorTestVerifySetup.setup(trackerName: UNIT_TEST_DEFAULT_TRACKER_NAME, appId: UNIT_TEST_DEFAULT_APP_ID)
        XCTAssertTrue(inspetorTestVerifySetup.verifySetup())
    }
    
    func testSupportsOptionalParams() {
        let inspetorTestOptionalParams: InspetorResource = InspetorResource()
        let nonDefaultUri = "random.uri.com"
        
        inspetorTestOptionalParams.setup(trackerName: UNIT_TEST_DEFAULT_TRACKER_NAME,
                               appId: UNIT_TEST_DEFAULT_APP_ID,
                               base64Encoded: nil,
                               collectorUri: nonDefaultUri,
                               httpMethodType: nil,
                               protocolType: nil)
        
        // Provided values are altered
        XCTAssertNotEqual(inspetorTestOptionalParams.getCollectorUri(), inspetorTestOptionalParams.DEFAULT_COLLECTOR_URI)
        XCTAssertEqual(inspetorTestOptionalParams.getCollectorUri(), nonDefaultUri)
        
        // Nil values remain default
        XCTAssertEqual(inspetorTestOptionalParams.getBase64Encoded(), inspetorTestOptionalParams.DEFAULT_BASE64_OPTION)
        XCTAssertEqual(inspetorTestOptionalParams.getHttpMethodType(), inspetorTestOptionalParams.DEFAULT_HTTP_METHOD_TYPE)
        XCTAssertEqual(inspetorTestOptionalParams.getProtocolType(), inspetorTestOptionalParams.DEFAULT_PROTOCOL_TYPE)
    }
    
    func testTrackerNameFormatValidation() {
        let invalidTrackerNameTooManyFields = "improper.tracker.name.format"
        XCTAssertFalse(inspetor.validateTrackerName(invalidTrackerNameTooManyFields))
        
        let invalidTrackerNameTooFewFields = "improper_tracker_name_format"
        XCTAssertFalse(inspetor.validateTrackerName(invalidTrackerNameTooFewFields))
        
        let invalidTrackerNameNoClientName = ".improper_tracker_name_format"
        XCTAssertFalse(inspetor.validateTrackerName(invalidTrackerNameNoClientName))
        
        let invalidTrackerNameNoProductName = "improper_tracker_name_format."
        XCTAssertFalse(inspetor.validateTrackerName(invalidTrackerNameNoProductName))
        
        let validTrackerName = "valid.tracker_name"
        XCTAssertTrue(inspetor.validateTrackerName(validTrackerName))
    }
}
