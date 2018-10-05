//
//  UserDefaultsSchema.swift
//  YosageSchema
//
//  Created by yuya-hirayama on 2018/10/04.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import Foundation

public protocol UserDefaultsSchema: Codable {
    static func getObject(data: Data) throws -> Self
}

//public extension UserDefaultsSchema {
//    public static func getObject(data: Data) throws -> Self {
//        return try JSONDecoder.init().decode(Self.self, from: data)
//    }
//}

public protocol MigratableFromPreviousVersionUserDefaultsSchema: UserDefaultsSchema {
    associatedtype PreviousVersionSchema: UserDefaultsSchema

    static func migrate(from: PreviousVersionSchema) throws -> Self
}

public extension MigratableFromPreviousVersionUserDefaultsSchema where PreviousVersionSchema: UserDefaultsSchema {
    public static func getObject(data: Data) throws -> Self {
        do {
            return try JSONDecoder.init().decode(Self.self, from: data)
        } catch _ {
            let previousVersionObject = try PreviousVersionSchema.getObject(data: data)
            return try migrate(from: previousVersionObject)
        }
    }
}
