//
//  InvoiceLineTests.swift
//  XeroProgrammingExerciseTests
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

@testable import XeroProgrammingExercise
import XCTest

class InvoiceLineTests: XCTestCase {
    func testPrice() {
        let line = Fixtures.InvoiceLine.pizza
        XCTAssertEqual(line.price, 9.99, accuracy: 0.01)
    }
    
    func testComparisonBasedOnId() {
        let line1 = InvoiceLine(invoiceLineId: 1, description: "", quantity: 0, cost: 0)
        let line2 = InvoiceLine(invoiceLineId: 2, description: "", quantity: 0, cost: 0)
        XCTAssertLessThan(line1, line2)
    }
}
