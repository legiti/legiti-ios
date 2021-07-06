import UIKit
import Legiti
import CoreLocation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var pickerView: UIPickerView!
    let legiti = Legiti.sharedInstance()
    let manager = CLLocationManager()
    let trackingActions = [
        "TrackLogin",
        "TrackLogout",
        "TrackUserCreation",
        "TrackUserUpdate",
        "TrackPassRecovery",
        "TrackOrderCreation"
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
        
        if (Legiti.sharedInstance().isConfigured()) {
            try! self.legiti.trackPageView(pageTitle: "TESTE")
        }
    
    }
    
    //MARK: Helper Functions
    private func runTrackingFunction(action: String) {
        switch action {
        case "TrackLogin":
            if (self.legiti.isConfigured()) {
                try! self.legiti.trackLogin(userEmail: "login@email.com", userId: "123")
            }
        case "TrackLogout":
            if (self.legiti.isConfigured()) {
                try! self.legiti.trackLogout(userEmail: "logout@email.com", userId: nil)
            }
        case "TrackUserCreation":
            if (self.legiti.isConfigured()) {
                try! self.legiti.trackUserCreation(userId: "123")
            }
        case "TrackUserUpdate":
            if (self.legiti.isConfigured()) {
                try! self.legiti.trackUserUpdate(userId: "123")
            }
        case "TrackPassRecovery":
            if (self.legiti.isConfigured()) {
                try! self.legiti.trackPasswordRecovery(userEmail: "pass_recovery@email.com")
            }
        case "TrackOrderCreation":
            if (self.legiti.isConfigured()) {
                try! self.legiti.trackOrderCreation(orderId: "123")
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
        if (self.legiti.isConfigured()) {
            try! self.legiti.trackPageView(pageTitle: "Teste")
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


