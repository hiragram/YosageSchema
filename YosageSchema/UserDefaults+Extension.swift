//
//  UserDefaults+Extension.swift
//  YosageSchema
//
//  Created by yuya-hirayama on 2018/10/04.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import Foundation

private let defaultKey = "keykeykeykeykeykeykeykey" // TODO

extension UserDefaults {
    func storedObject<T: UserDefaultsSchema>() throws -> T {
        guard let data = data(forKey: defaultKey) else {
            throw Error.noSavedObject
        }
        return try T.getObject(data: data)
    }

    func update<T: UserDefaultsSchema>(objectToStore object: T) throws {
        let data = try JSONEncoder.init().encode(object)
        set(data, forKey: defaultKey)
        synchronize()
    }
}
