//
//  StoredElementTests.swift
//  YosageSchemaTests
//
//  Created by yuya-hirayama on 2018/10/05.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import XCTest
@testable import YosageSchema

class StoredElementTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_codable() {
        none: do {
            let none = StoredElement<Int>.none

            let encoded = try! JSONEncoder.init().encode(none)
            let decoded = try! JSONDecoder.init().decode(StoredElement<Int>.self, from: encoded)

            XCTAssertEqual(none, decoded)
        }

        notSet: do {
            let notSet = StoredElement<Int>.notSet

            let encoded = try! JSONEncoder.init().encode(notSet)
            let decoded = try! JSONDecoder.init().decode(StoredElement<Int>.self, from: encoded)

            XCTAssertEqual(notSet, decoded)
        }
    }
}

