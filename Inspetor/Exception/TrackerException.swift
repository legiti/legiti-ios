//
//  TrackerException.swift
//  Inspetor
//
//  Created by Inspetor on 10/07/19.
//  Copyright © 2019 Inspetor. All rights reserved.
//

import Foundation

public enum TrackerException: Error {
    case requiredConfig(code: Int, message: String)
    case internalError(message: String)
}
