//
//  Schema.swift
//  Sample
//
//  Created by yuya-hirayama on 2018/10/04.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import Foundation
import YosageSchema

struct Schema {
    typealias Latest = V2

    struct V1: UserDefaultsSchema {
        static func getObject(data: Data) throws -> Schema.V1 {
            return (try? JSONDecoder.init().decode(V1.self, from: data)) ?? .init(message: .notSet)
        }


        var message: StoredElement<String>
    }

    struct V2: MigratableFromPreviousVersionUserDefaultsSchema {
        var message: StoredElement<String>

        // You can also choose Int instead of Optional<Int> or StoredElement<Int> if you want to use default value implicitly.
        var tapCount: Int

        typealias PreviousVersionSchema = V1

        static func migrate(from previous: Schema.V1) throws -> Schema.V2 {
            return V2.init(
                message: previous.message,
                tapCount: 0 // <- default value
            )
        }
    }
}

