//
//  File.swift
//  XeroProgrammingExercise
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    // Deduplicating identifiable arrays and returning the first occurance
    func deduplicate() -> Array<Element> {
        var itemMap = reduce(into: [Element: [Element]]()) { partialResult, next in
            let current = partialResult[next, default: []] + [next]
            partialResult[next] = current
        }
        
        return compactMap{ id in
            guard let value = itemMap[id]?.first else { return nil }
            itemMap[id] = nil
            return value
        }
    }
}
