//
//  StoredElement.swift
//  YosageSchema
//
//  Created by yuya-hirayama on 2018/10/04.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import Foundation

public enum StoredElement<T: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case `case`
        case valueForCaseSome
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        switch try values.decode(String.self, forKey: .case) {
        case "notSet":
            self = .notSet
        case "none":
            self = .none
        case "some":
            let payloadValue = try values.decode(T.self, forKey: .valueForCaseSome)
            self = .some(payloadValue)
        default:
            fatalError()
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let caseName: String
        switch self {
        case .none:
            caseName = "none"
        case .notSet:
            caseName = "notSet"
        case .some(_):
            caseName = "some"
        }
        try container.encode(caseName, forKey: .case)

        switch self {
        case .some(let payloadValue):
            try container.encode(payloadValue, forKey: .valueForCaseSome)
        default:
            break
        }
    }

    case notSet
    case none
    case some(T)

    public func map<U>(_ block: (T) throws -> (U)) rethrows -> U? {
        switch self {
        case .some(let payloadValue):
            return try block(payloadValue)
        case .none, .notSet:
            return nil
        }
    }
}

extension StoredElement where T: Equatable {
    static func == (lhs: StoredElement<T>, rhs: StoredElement<T>) -> Bool {
        switch (lhs, rhs) {
        case (.some(let l), .some(let r)):
            return l == r
        case (.none, .none),
             (.notSet, .notSet):
            return true
        default:
            return false
        }
    }
}
