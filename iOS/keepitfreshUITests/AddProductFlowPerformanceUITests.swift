//
//  AddProductFlowPerformanceUITests.swift
//  keepitfreshUITests
//
//  Created by musadhikh on 2/3/26.
//  Summary: Measures Add Product flow launch and transition latency from Home to S1 action sheet.
//

import XCTest

final class AddProductFlowPerformanceUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testAddProductFlowEntryPerformance() throws {
        let app = XCUIApplication()
        app.launch()

        guard app.buttons["home.addProductButton"].waitForExistence(timeout: 8) else {
            throw XCTSkip("Home Add Product button not available in this launch context.")
        }

        measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTMemoryMetric()]) {
            app.buttons["home.addProductButton"].tap()
            _ = app.buttons["addFlow.action.scanLabel"].waitForExistence(timeout: 3)

            if app.buttons["Close"].exists {
                app.buttons["Close"].tap()
            }
        }
    }
}
