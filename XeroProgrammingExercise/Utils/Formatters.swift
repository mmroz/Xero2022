//
//  Formatters.swift
//  XeroProgrammingExercise
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

import Foundation

enum Formatters {
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/MM/YYYY"
        return formatter
    }
    
    static func currencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
