//
//  ArrayTests.swift
//  XeroProgrammingExerciseTests
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

import Foundation
import XCTest
@testable import XeroProgrammingExercise

class ArrayTests: XCTestCase {
    func testDeduplicate() {
        XCTAssertEqual([Int]().deduplicate(), [])
        XCTAssertEqual([1,2,3].deduplicate(), [1,2,3])
        XCTAssertEqual([1,1,1,2,3].deduplicate(), [1,2,3])
        XCTAssertEqual([3,3,3,2,2,1,1].deduplicate(), [3,2,1])
    }
}
