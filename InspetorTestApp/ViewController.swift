//
//  ViewController.swift
//  inspetorTestApp
//
//  Created by Inspetor on 14/08/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import UIKit
import Inspetor
import CoreLocation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var pickerView: UIPickerView!
    let inspetor = Inspetor.sharedInstance()
    let manager = CLLocationManager()
    let trackingActions = [
        "TrackLogin",
        "TrackLogout",
        "TrackAccountCreation",
        "TrackAccountUpdate",
        "TrackAccountDeletion",
        "TrackPassRecovery",
        "TrackPassReset",
        "TrackEventCreation",
        "TrackEventUpdate",
        "TrackEventDeletion",
        "TrackTransferCreation",
        "TrackTransferUpdate",
        "TrackSaleCreation",
        "TrackSaleUpdate"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        print(self.trackingActions.count)
        if CLLocationManager.locationServicesEnabled() {
            if (CLLocationManager.authorizationStatus() != .authorizedAlways || CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
                manager.requestWhenInUseAuthorization()
            }
        }
        
        if (Inspetor.sharedInstance().isConfigured()) {
            try! self.inspetor.trackPageView(pageTitle: "TESTE")
        }
    
    }
    
    //MARK: Helper Functions
    private func runTrackingFunction(action: String) {
        switch action {
        case "TrackLogin":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackLogin(accountEmail: "login@email.com", accountId: "123")
            }
        case "TrackLogout":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackLogout(accountEmail: "logout@email.com", accountId: nil)
            }
        case "TrackAccountCreation":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackAccountCreation(accountId: "123")
            }
        case "TrackAccountUpdate":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackAccountUpdate(accountId: "123")
            }
        case "TrackAccountDeletion":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackAccountDeletion(accountId: "123")
            }
        case "TrackPassRecovery":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackPasswordRecovery(accountEmail: "pass_recovery@email.com")
            }
        case "TrackPassReset":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackPasswordReset(accountEmail: "pass_recovery@email.com")
            }
        case "TrackEventCreation":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackEventCreation(eventId: "123")
            }
        case "TrackEventUpdate":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackEventUpdate(eventId: "123")
            }
        case "TrackEventDeletion":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackEventDeletion(eventId: "123")
            }
        case "TrackTransferCreation":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackItemTransferCreation(transferId: "123")
            }
        case "TrackTransferUpdate":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackItemTransferUpdate(transferId: "123")
            }
        case "TrackSaleCreation":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackSaleCreation(saleId: "123")
            }
        case "TrackSaleUpdate":
            if (self.inspetor.isConfigured()) {
                try! self.inspetor.trackSaleUpdate(saleId: "123")
            }
        default:
            print("ERROR")
        }
    }
    
    //MARK: Actions
    @IBAction func trackAction(_ sender: UIButton) {
        
        let action = self.trackingActions[self.pickerView.selectedRow(inComponent: 0)]
        self.runTrackingFunction(action: action)
        
    }
    
    @IBAction func trackAllActions(_ sender: UIButton) {
        for action in self.trackingActions {
            self.runTrackingFunction(action: action)
        }
    }
    
    @IBAction func trackScreenView(_ sender: UIButton) {
        if (self.inspetor.isConfigured()) {
            try! self.inspetor.trackPageView(pageTitle: "Teste")
        }
    }
    
    //MARK: UIPickerViewDataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.trackingActions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.trackingActions[row]
    }
}


