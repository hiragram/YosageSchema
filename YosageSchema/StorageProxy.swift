//
//  StorageProxy.swift
//  YosageSchema
//
//  Created by yuya-hirayama on 2018/10/04.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import Foundation

public class UserDefaultsStorageProxy<Schema: UserDefaultsSchema> {
    private let defaults: UserDefaults
    public private(set) var storedObject: Schema {
        didSet {
            print(storedObject)
            try! defaults.update(objectToStore: storedObject)
        }
    }

    public init(storage: UserDefaults) {
        defaults = storage
        if let storedObject = try? defaults.storedObject() as Schema {
            self.storedObject = storedObject
        } else {
            self.storedObject = try! Schema.getObject(data: Data.init())
        }
    }

    public func modify(block: (inout Schema) -> ()) {
        block(&storedObject)
    }
}
