//
//  InvoiceRowBuilder.swift
//  XeroProgrammingExercise
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

import UIKit

enum InvoiceRowBuilder {
    /// - Parameters:
    ///   - items: The invoice row items
    static func sections(items: [InvoiceRowViewModel]) -> NSDiffableDataSourceSnapshot<InvoicesListViewController.TableSections, InvoiceRowViewModel> {
        var snapshot = NSDiffableDataSourceSnapshot<InvoicesListViewController.TableSections, InvoiceRowViewModel>()
        if !items.isEmpty {
            snapshot.appendSections([.all])
            snapshot.appendItems(items, toSection: .all)
        }
        return snapshot
    }
}
