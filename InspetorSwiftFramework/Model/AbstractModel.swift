//
//  AbstractModel.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 07/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class AbstractModel {
    
    //MARK: EncodeData
    internal func encodeData(stringToEncode: String?) -> String? {
        if let str = stringToEncode {
            if let data = str.data(using: .utf8) {
                return data.base64EncodedString()
            }
        }
        return nil
    }
    
    //MARK: EncodeObject
    internal func encodeObject(objectToEncode: InspetorSerialize?) -> Dictionary<String, Any?>?{
        if let obj = objectToEncode {
            return obj.toJson()
        }
        return nil
    }

    //MARK: EncodeArray
    internal func encodeArray(arrayToEncode: Array<Any>?, isObject: Bool) -> [Any]? {
        var encodedArray: [Any] = []
        
        if let array = arrayToEncode {
            for data in array {
                if isObject {
                    guard let obj = data as? InspetorSerialize else {
                        //should throw exception
                        return nil
                    }
                    encodedArray.append(self.encodeObject(objectToEncode: obj)!)
                } else {
                    guard let str = data as? String else {
                        //should throw exception
                        return nil
                    }
                    encodedArray.append(self.encodeData(stringToEncode: str)!)
                }
            }
            return encodedArray
        }
        return nil
    }
    
    internal func inspetorDateFormatter(time: Int) -> String {
        var unix: TimeInterval = Double(time)
        
        let date = Date(timeIntervalSince1970: unix)
        let strDate = date.description
        
        return strDate
    }
    
}

