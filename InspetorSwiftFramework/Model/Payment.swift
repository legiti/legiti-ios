//
//  Payment.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

class Payment: AbstractModel, InspetorSerialize {
    
    //MARK: Methods
    enum paymentMethods: String {
        case credit_card = "credit_card"
        case boleto = "boleto"
        case other = "other"
    }
    
    //MARK: Properties
    var id: String
    var method: paymentMethods
    var installments: Int
    var creditCard: CreditCard?
    
    //MARK: init
    init(id: String, method: paymentMethods, installments: Int) {
        self.id = id
        self.method = method
        self.installments = installments
    }
    
    //MARK: toJson
    func toJson() -> Dictionary<String, Any?> {
        var dict = [String: Any?]()
        
        dict["payment_instance_id"] = self.encodeData(stringToEncode: self.id)
        dict["payment_instance_method"] = self.encodeData(stringToEncode: self.method.rawValue)
        dict["payment_instance_installments"] = self.encodeData(stringToEncode: String(self.installments))
        dict["payment_instance_credit_card_info"] = self.encodeObject(objectToEncode: self.creditCard)

        return dict
    }
    
}
