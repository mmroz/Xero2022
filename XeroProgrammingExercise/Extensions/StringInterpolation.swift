//
//  StringInterpolation.swift
//  XeroProgrammingExercise
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Decimal, currencyFormatter: NumberFormatter) {
        if let value = currencyFormatter.string(from: value as NSNumber) {
            appendInterpolation(value)
        }
    }
}
