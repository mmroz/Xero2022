//
//  InvoiceRowCell.swift
//  XeroProgrammingExercise
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

import Foundation
import SwiftUI

struct InvoiceCell: View {
    
    private let invoice: InvoiceRowViewModel
    private let dateFormatter: DateFormatter
    private let currencyFormatter: NumberFormatter
    
    init(invoice: InvoiceRowViewModel, dateFormatter: DateFormatter, currencyFormatter: NumberFormatter) {
        self.invoice = invoice
        self.dateFormatter = dateFormatter
        self.currencyFormatter = currencyFormatter
    }
    
    var body: some View {
        let invoiceNumber = invoice.invoiceNumber.map{ "\($0)" } ?? "-"
        HStack(spacing: 4) {
            VStack(alignment: .leading) {
                Text(invoiceNumber)
                    .foregroundColor(.white)
                Spacer()
                Text(invoice.invoiceDate ?? Date(), formatter: dateFormatter)
                    .foregroundColor(.white)
            }
            Spacer()
            VStack(alignment: .trailing) {
                // TODO - handle localization correctly to show 1 item/ 2 items
                Text(String(localized: "\(invoice.lineItemCount) items", comment: "Number of invoice line items"))
                    .foregroundColor(.white)
                Spacer()
                Text(verbatim: "\(invoice.invoiceTotal, currencyFormatter: currencyFormatter)")
                    .foregroundColor(.blue)
            }
        }
    }
}
