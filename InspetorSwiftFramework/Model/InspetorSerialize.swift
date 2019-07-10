//
//  protocolModel.swift
//  InspetorSwiftFramework
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

protocol  InspetorSerialize {
    func toJson() -> Dictionary<String, Any?>
}
