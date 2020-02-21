import XCTest
@testable import Inspetor

class LegitiIntegrationTests: XCTestCase {
    
    // This tokens were created using the JWT website. The "middle part" is `{"principalId": "inspetor_test"}`
    private static let sandboxAuthToken: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwcmluY2lwYWxJZCI6Imluc3BldG9yX3Rlc3QifQ.NJ89yQB1sIiR8qeIpIt5SDOJ45hUZBLQVVbQFVJ-lKo"

    private func setUpTracker() {
        do {
            //For this tests you need to change the applicationContext (SnowplowManager->setupTracker->newTracker->builder!.setApplicationContext()) to false
            //Otherwise the tests wont work since this is not an app
            try Legiti.sharedInstance().setup(authToken: LegitiIntegrationTests.sandboxAuthToken, legitiDevEnv: true)
        } catch {
            fatalError("Error when initializing the tracker")
        }
    }
    
    func testUserCreation() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackUserCreation(userId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testUserUpdate() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackUserUpdate(userId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLogin() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackLogin(userEmail: "login@email.com", userId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLogout() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackLogout(userEmail: "logout@email.com", userId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLoginWithoutUserId() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackLogin(userEmail: "login@email.com", userId: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLogoutWithoutUserId() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackLogout(userEmail: "logout@email.com", userId: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPassRecovery() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackPasswordRecovery(userEmail: "pass@recovery.com")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPassReset() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackPasswordReset(userId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testSaleCreation() {
        let expectation = self.expectation(description: "Send Data")
        
        self.setUpTracker()
        if Legiti.sharedInstance().isConfigured() {
            try! Legiti.sharedInstance().trackOrderCreation(orderId: "123")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
    }

}
