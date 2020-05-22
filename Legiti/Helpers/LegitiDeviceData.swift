import Foundation
import SwiftKeychainWrapper


internal class LegitiDeviceData {
    
    private var deviceData = [String: Any?]()
    
    internal func getDeviceData() -> Dictionary<String, Any?> {
        // We are doing this so we dont have to check everything everytime
        if !(deviceData.isEmpty) {
            return deviceData
        }

        var data = [String: Any?]()
        
        // We need to do the '?? nil as Any?' since, otherwise, we won't even send
        // device_fingerprint if it's equal no nil
        data["device_fingerprint"] = self.getDeviceFingerprint() ?? nil as Any?
        data["customer_device_fingerprint"] = self.getCustomerDeviceFingerprint() ?? nil as Any?
        data["is_simulator"] = self.getIsSimulator()
        data["is_rooted"] = self.getIsJailbroken()
        data["is_vpn"] = self.getIsVPNConnected()
        self.deviceData = datas
        
        return data
    }
    
    private func getDeviceFingerprint() -> String? {
        return LegitiFingerprint.getDeviceFingerprint()
    }
    
    private func getCustomerDeviceFingerprint() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString ?? nil
    }
    
    private func getIsSimulator() -> Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
    
    private func getIsJailbroken() -> Bool {
        return JailbreakChecker.jailbreakCheck()
    }
    
    private func getIsVPNConnected() -> Bool {
        if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? Dictionary<String, Any>,
            let scopes = settings["__SCOPED__"] as? [String:Any] {
            for (key, _) in scopes {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
                    return true
                }
            }
        }
        return false
    }
}


//MARK: LegitiFingerprint
internal class LegitiFingerprint {
    
    private static var deviceFingerprint: String?
    private static let legitiKey: String = "legitiFingerprint"
    
    internal static func getDeviceFingerprint() -> String? {
        if self.deviceFingerprint == nil {
            if let deviceID = self.retrieveDeviceFingerprint() {
                self.deviceFingerprint = deviceID
                return self.deviceFingerprint!
            }
            
            let deviceID = self.createDeviceFingerprint()
            if self.saveDeviceFingerprint(deviceID: deviceID) {
                self.deviceFingerprint = deviceID
                return self.deviceFingerprint!
            }
            return nil
        }
        return self.deviceFingerprint!
    }
    
    private static func createDeviceFingerprint() -> String {
        return UUID().uuidString
    }
    
    private static func saveDeviceFingerprint(deviceID: String) -> Bool {
        if KeychainWrapper.standard.set(deviceID, forKey: self.legitiKey) {
            return true
        }
        return false
    }
    
    private static func retrieveDeviceFingerprint() -> String? {
        return KeychainWrapper.standard.string(forKey: self.legitiKey)
    }
    
    
}


//MARK; JailbrakChecker
internal class JailbreakChecker {
    
    internal static func jailbreakCheck() -> Bool {
        if TARGET_IPHONE_SIMULATOR != 1 {
            // Check 1 : existence of files that are common for jailbroken devices
            for path in Const.files {
                if FileManager.default.fileExists(atPath: path) {
                    return true
                }
            }
            
            // Check 2: existence of applications that are common for jailbroken devices (if they are accesable then there is a sandbox violation wich means the device is jailbroken)
            for path in Const.applications {
                if UIApplication.shared.canOpenURL(URL(string: path)!) {
                    return true
                }
            }
            
            // Check 3 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do {
                try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                //Device is jailbroken
                return true
            } catch {
                //reasons["Read and write acces"] = false
                return false
            }
        }
        return false
    }
    
    struct Const {
        
        static let files = ["/Applications/Cydia.app",
                            "/Applications/blackra1n.app",
                            "/Applications/FakeCarrier.app",
                            "/Applications/Icy.app",
                            "/Applications/IntelliScreen.app",
                            "/Applications/MxTube.app",
                            "/Applications/RockApp.app",
                            "/Applications/SBSettings.app",
                            "/Applications/WinterBoard.app",
                            "/Library/MobileSubstrate/MobileSubstrate.dylib",
                            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                            "/private/var/mobile/Library/SBSettings/Themes",
                            "/private/var/stash",
                            "/private/var/lib/cydia",
                            "/private/var/lib/apt/",
                            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                            "/bin/bash",
                            "/usr/sbin/sshd",
                            "/etc/apt"]
        
        static let applications = [ // accesing other IOS applications is a sandbox violations
            "cydia://package/com.example.package"
        ]
    }
}
