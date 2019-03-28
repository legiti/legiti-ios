//
//  InspetorService.swift
//  InspetorSwiftFramework
//
//  Created by Pearson Henri on 3/25/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SnowplowTracker

protocol InspetorService {
    static var sharedInstance: Self { get }
    
    var trackerName: String? {get set}
    var appId: String? {get set}
    var base64Encoded: Bool {get set}
    var collectorUri : String {get set}
    var httpMethodType : SPRequestOptions {get set}
    var protocolType : SPProtocol {get set}
    
    var tracker : SPTracker? {get set}
    
    // set active user account
    func setActiveUser(_ userId: Int)

    func unsetActiveUser()
    
    // track account creation
    func trackAccountCreation(_ userId: Int)

    // track account update
    func trackAccountUpdate(_ userId: Int)

    // track create order
    func trackCreateOrder(_ txnId: Int)

    // track pay order
    func trackPayOrder(_ txnId: Int)
    
    // track cancel order
    func trackCancelOrder(_ txnId: Int)
}
