//
//  InvoiceRowViewModel.swift
//  XeroProgrammingExercise
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

import Foundation

struct InvoiceRowViewModel {
   private let invoice: Invoice
    
    /// Invoice number
    var invoiceNumber: Int? {
        invoice.invoiceNumber
    }
    
    /// invoice date
    var invoiceDate: Date? {
        invoice.invoiceDate
    }
    
    /// The total of the invoice
    var invoiceTotal: Decimal {
        invoice.total
    }
    
    /// Invoice  item count
    var lineItemCount: Int {
        invoice.lineItems.count
    }
    
    // MARK: - Init
    
    /// - Parameters:
    ///   - invoice: The invoice
    init(invoice: Invoice) {
        self.invoice = invoice
    }
}

// MARK: - Equatable

extension InvoiceRowViewModel: Equatable {
    static func == (lhs: InvoiceRowViewModel, rhs: InvoiceRowViewModel) -> Bool {
        lhs.invoiceNumber == rhs.invoiceNumber && lhs.invoiceDate == rhs.invoiceDate && lhs.invoice.lineItems == rhs.invoice.lineItems
    }
}

// MARK: - Hashable

extension InvoiceRowViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(invoice.uuid)
    }
}

