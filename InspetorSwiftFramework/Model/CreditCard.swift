//
//  CreditCard.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class CreditCard: AbstractModel, InspetorSerialize {
    
    //MARK: Properties
    var firstSixDigits: String
    var lastFourDigits: String
    var holderName: String
    var holderCpf: String
    
    //MARK: init
    init(firstSixDigits: String, lastFourDigits: String, holderName: String, holderCpf: String) {
        self.firstSixDigits = firstSixDigits
        self.lastFourDigits = lastFourDigits
        self.holderName = holderName
        self.holderCpf = holderCpf
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["cc_first_six"] = self.encodeData(stringToEncode: self.firstSixDigits)
        dict["cc_last_four"] = self.encodeData(stringToEncode: self.lastFourDigits)
        dict["cc_holder_name"] = self.encodeData(stringToEncode: self.holderName)
        dict["cc_holder_cpf"] = self.encodeData(stringToEncode: self.holderCpf)
        
        return dict
    }
    
    
}
