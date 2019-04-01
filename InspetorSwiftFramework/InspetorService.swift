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
    var trackerName: String? {get set}
    var appId: String? {get set}
    var base64Encoded: Bool {get set}
    var collectorUri : String {get set}
    var httpMethodType : SPRequestOptions {get set}
    var protocolType : SPProtocol {get set}
    
    var tracker : SPTracker? {get set}
    
    func setup(trackerName: String,
        appId: String,
        base64Encoded: Bool?,
        collectorUri : String?,
        httpMethodType : SPRequestOptions?,
        protocolType : SPProtocol?)
    
    // set active user account
    func setActiveUser(_ userId: String)

    func unsetActiveUser()
    
    func trackLogin(_ userId: String)
    
    func trackLogout(_ userId: String)

    func trackAccountCreation(_ userId: String)

    func trackAccountUpdate(_ userId: String)

    func trackCreateOrder(_ txnId: String)

    func trackPayOrder(_ txnId: String)
    
    func trackCancelOrder(_ txnId: String)
    
    func trackTicketTransfer(ticketId: String, userId: String, recipient: String)
    
    func trackRecoverPasswordRequest(_ email: String)
    
    func trackChangePassword(_ email: String)
}
