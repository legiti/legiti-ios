//
//  InspetorFingerprint.swift
//  Inspetor
//
//  Created by Inspetor on 14/08/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper


internal class InspetorDeviceData {
    
    private var deviceData: Dictionary<String, Any>?
    
    internal func getDeviceData() -> Dictionary<String, Any>? {
        // We are doing this so we dont have to check everything everytime
        if deviceData != nil {
            return deviceData
        }

        var data = [String: Any]()
        
        if  let deviceFingerprint = self.getDeviceFingerprint() {
            data["device_fingerprint"] = deviceFingerprint
            data["is_simulator"] = self.getIsSimulator()
            data["is_rooted"] = self.getIsJailbroken()
            self.deviceData = data
            return data
        }
        return nil
    }
    
    private func getDeviceFingerprint() -> String? {
        do {
            let deviceID = try InspetorFingerprint.getDeviceFingerprint()
            return deviceID
        } catch (let message) {
            print(message)
            return nil
        }
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
}


//MARK; InspetorFingerprint
internal class InspetorFingerprint {
    
    private static var deviceFingerprint: String?
    private static let inspetorKey: String = "inspetorFingerprint"
    
    internal static func getDeviceFingerprint() throws -> String {
        if self.deviceFingerprint == nil {
            if let deviceID = self.retrieveDeviceFingerprint() {
                self.deviceFingerprint = deviceID
                return self.deviceFingerprint!
            }
            
            let deviceID = self.createDeviceFingerprint()
            if self.saveDeviceFingerprint(deviceID: deviceID) {
                self.deviceFingerprint = deviceID
                return self.deviceFingerprint!
            } else {
                throw TrackerException.internalError(message: "InspetorLog: An error occured")
            }
        }
        return self.deviceFingerprint!
    }
    
    private static func createDeviceFingerprint() -> String {
        return UUID().uuidString
    }
    
    private static func saveDeviceFingerprint(deviceID: String) -> Bool {
        if KeychainWrapper.standard.set(deviceID, forKey: self.inspetorKey) {
            return true
        }
        return false
    }
    
    private static func retrieveDeviceFingerprint() -> String? {
        return KeychainWrapper.standard.string(forKey: self.inspetorKey)
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
