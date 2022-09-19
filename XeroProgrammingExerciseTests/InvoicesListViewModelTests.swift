//
//  InvoicesListViewModelTests.swift
//  XeroProgrammingExerciseTests
//
//  Created by Mark Mroz on 2022-09-17.
//  Copyright © 2022 Xero Ltd. All rights reserved.
//

@testable import XeroProgrammingExercise
import XCTest
import Combine

class InvoicesListViewModelTests: XCTestCase {
    func testLoadingSetsDataSource() {
        let expectation = self.expectation(description: "Sets data source")
        let invoice = InvoicesListViewModel(dataSource: [])
        var cancellables = Set<AnyCancellable>()
        invoice.$dataSource
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 0.5)
    }
}
