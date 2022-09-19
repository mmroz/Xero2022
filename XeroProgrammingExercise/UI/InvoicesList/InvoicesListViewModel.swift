//
//  InvoicesListViewModel.swift
//  XeroProgrammingExercise
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

import Foundation
import Combine

final class InvoicesListViewModel: ObservableObject {
    @Published private(set) var dataSource: [InvoiceRowViewModel]
    
    // MARK: - Init
    
    /// - Parameters:
    ///   - dataSource: The invoice row view models
    init(dataSource: [InvoiceRowViewModel]) {
        self.dataSource = dataSource
    }
    
    // MARK: - Public
    
    /// Refresh the view model with the most recent data
    func load() {
        dataSource = [
            Invoice(lineItems: [
                InvoiceLine(invoiceLineId: 1,
                            description: "Orange",
                            quantity: 1,
                            cost: 5.22)
            ]),
            Invoice(lineItems: [
                InvoiceLine(invoiceLineId: 2,
                            description: "Blueberries",
                            quantity: 3,
                            cost: 6.27)
            ]),
            Invoice(lineItems: [
                InvoiceLine(invoiceLineId: 1,
                            description: "Pizza",
                            quantity: 1,
                            cost: 9.99)
            ]),
        ].map(InvoiceRowViewModel.init(invoice:))
    }
}
