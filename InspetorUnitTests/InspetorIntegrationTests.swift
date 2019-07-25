//
//  InspetorIntegrationTests.swift
//  InspetorUnitTests
//
//  Created by Inspetor on 17/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import XCTest
@testable import Inspetor

class InspetorIntegrationTests: XCTestCase {

    private func setUpTracker() {
        do {
            try Inspetor.sharedInstance().setup(appId: "123", trackerName: "inspetor.ios.test", devEnv: true, inspetorEnv: true)
        } catch {
            fatalError("Error when initializing the tracker")
        }
    }
    
    func testAccountCreation() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackAccountCreation(accountId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testAccountUpdate() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackAccountUpdate(accountId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testAccountDeletion() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackAccountDeletion(accountId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLogin() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackLogin(accountId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLogout() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackLogout(accountId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPassRecovery() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackPasswordRecovery(accountEmail: "pass@recovery.com")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPassReset() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackPasswordReset(accountEmail: "pass@recovery.com")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testEventCreation() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackEventCreation(eventId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testEventDeletion() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackEventDeletion(eventId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testSaleCreation() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackSaleCreation(saleId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testSaleUpdate() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackSaleUpdate(saleId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testTransferCreation() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackItemTransferCreation(transferId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testTransferUpdate() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Inspetor.sharedInstance().isConfigured() {
            try! Inspetor.sharedInstance().trackItemTransferUpdate(transferId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }

}
