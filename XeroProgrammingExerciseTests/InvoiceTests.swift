//
//  InvoiceTests.swift
//  XeroProgrammingExerciseTests
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

@testable import XeroProgrammingExercise
import XCTest

class InvoiceTests: XCTestCase {
    func testAddInvoiceLineAddsInvoiceLine() {
        var invoice = Fixtures.Invoice.empty
        invoice.addInvoiceLine(Fixtures.InvoiceLine.pizza)
        XCTAssertEqual(invoice.lineItems.count, 1)
    }
    
    func testTotalCalculatesSumOfInvoiceLines() {
        let invoice = Fixtures.Invoice.withLineItems
        XCTAssertEqual(invoice.total, 71.67, accuracy: 0.01)
    }
    
    func testRemoveLineItem() throws {
        var invoice = Fixtures.Invoice.withLineItems
        let idToRemove = try XCTUnwrap(invoice.lineItems.first?.invoiceLineId)
        invoice.removeInvoiceLine(with: idToRemove)
        
        XCTAssertFalse(invoice.lineItems.contains{ $0.invoiceLineId == idToRemove })
    }
    
    func testMergingInvoicesConcatenatesItems() {
        var pizza = Fixtures.Invoice.singlePizza
        let orange = Fixtures.Invoice.singleOrange
        pizza.mergeInvoices(sourceInvoice: orange)
        
        XCTAssertEqual(pizza.lineItems, [Fixtures.InvoiceLine.pizza, Fixtures.InvoiceLine.orange])
    }
    
    func testMergingInvoicesRemovesDuplicateItems() {
        var pizza = Fixtures.Invoice.singlePizza
        let otherPizza = Fixtures.Invoice.singlePizza
        pizza.mergeInvoices(sourceInvoice: otherPizza)
        XCTAssertEqual(pizza.lineItems, [Fixtures.InvoiceLine.pizza])
    }
    
    func testCloningCreatesNewUUID() {
        let pizza = Fixtures.Invoice.singlePizza
        let clondedPizza = pizza.clone()
        
        XCTAssertNotEqual(pizza.uuid, clondedPizza.uuid)
        XCTAssertEqual(pizza.invoiceNumber, clondedPizza.invoiceNumber)
        XCTAssertEqual(pizza.invoiceDate, clondedPizza.invoiceDate)
        XCTAssertEqual(pizza.lineItems, clondedPizza.lineItems)
    }
    
    func testToString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let invoice = Fixtures.Invoice.withLineItems
        XCTAssertEqual(invoice.toString(dateFormatter: dateFormatter), "Invoice Number: nil, InvoiceDate: nil, LineItemCount: 3")
        
        let emptyInvoice = Fixtures.Invoice.empty
        XCTAssertEqual(emptyInvoice.toString(dateFormatter: dateFormatter), "Invoice Number: nil, InvoiceDate: nil, LineItemCount: 0")
    }
    
    func testOrderLineItemReturnsLineItemsInAscendingOrderById() {
        let invoice = Invoice(lineItems: [
            Fixtures.InvoiceLine.pizza,
            Fixtures.InvoiceLine.banana,
        ])
        
        XCTAssertEqual(invoice.oderLineItems, [Fixtures.InvoiceLine.banana, Fixtures.InvoiceLine.pizza])
    }
    
    func testPreviewLineItemsReturnsSublistFromFirstIndexToMax() {
        XCTAssert(Fixtures.Invoice.withLineItems.previewLineItems(0).isEmpty)
        XCTAssert(Fixtures.Invoice.empty.previewLineItems(0).isEmpty)
        XCTAssertEqual(Fixtures.Invoice.withLineItems.previewLineItems(2).count, 2)
        XCTAssertEqual(Fixtures.Invoice.withLineItems.previewLineItems(100).count, 3)
    }
    
    func testRemove() {
        var invoice = Invoice(lineItems: [
            Fixtures.InvoiceLine.pizza,
            Fixtures.InvoiceLine.banana,
        ])
        
        let otherInvoice = Invoice(lineItems: [
            Fixtures.InvoiceLine.pizza,
        ])
        
        invoice.removeItems(from: otherInvoice)
        XCTAssertEqual(invoice.lineItems.count, 1)
    }
}
