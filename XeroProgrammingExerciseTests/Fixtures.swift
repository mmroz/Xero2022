//
//  Fixtures.swift
//  XeroProgrammingExerciseTests
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

@testable import XeroProgrammingExercise
import XCTest

enum Fixtures {
    static func date(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        DateComponents(calendar: .autoupdatingCurrent, timeZone: .gmt, year: year, month: month, day: day, hour: hour, minute: minute, second: second).date!
    }
    
    enum Invoice {
        static let empty: XeroProgrammingExercise.Invoice = .init(
            uuid: "1",
            invoiceNumber: nil,
            invoiceDate: nil,
            lineItems: []
        )
        
        static let singlePizza: XeroProgrammingExercise.Invoice = .init(
            uuid: "2",
            invoiceNumber: 1,
            invoiceDate: Fixtures.date(year: 2022, month: 03, day: 19),
            lineItems: [InvoiceLine.pizza]
        )
        
        static let singleOrange: XeroProgrammingExercise.Invoice = .init(
            uuid: "3",
            invoiceNumber: nil,
            invoiceDate: nil,
            lineItems: [InvoiceLine.orange]
        )
        
        static let withLineItems: XeroProgrammingExercise.Invoice = .init(
            uuid: "4",
            invoiceNumber: nil,
            invoiceDate: nil,
            lineItems: [
                InvoiceLine.pizza,
                InvoiceLine.banana,
                InvoiceLine.orange,
            ]
        )
    }
    
    enum InvoiceLine {
        static let banana: XeroProgrammingExercise.InvoiceLine = .init(
            invoiceLineId: 1,
            description: "Banana",
            quantity: 4,
            cost: 10.21
        )
        
        static let orange: XeroProgrammingExercise.InvoiceLine = .init(
            invoiceLineId: 2,
            description: "Orange",
            quantity: 4,
            cost: 5.21
        )
        
        static let pizza: XeroProgrammingExercise.InvoiceLine = .init(
            invoiceLineId: 3,
            description: "Pizza",
            quantity: 1,
            cost: 9.99
        )
    }
}
