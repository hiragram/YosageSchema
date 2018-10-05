//
//  Error.swift
//  YosageSchema
//
//  Created by yuya-hirayama on 2018/10/04.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import Foundation

public enum Error: Swift.Error {
    case noSavedObject

    public var localizedDescription: String {
        switch self {
        case .noSavedObject:
            return "There are no saved schema object."
        }
    }
}
