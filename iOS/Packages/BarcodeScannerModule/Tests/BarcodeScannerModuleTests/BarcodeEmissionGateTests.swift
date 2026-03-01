//
//  BarcodeEmissionGateTests.swift
//  keepitfresh
//
//  Created by musadhikh on 19/2/26.
//  Summary: Verifies duplicate barcode gating behavior to keep scanner callbacks responsive and predictable.
//

import XCTest
@testable import BarcodeScannerModule

final class BarcodeEmissionGateTests: XCTestCase {
    func testAllowsFirstEmission() {
        var gate = BarcodeEmissionGate(duplicateFilterInterval: 1.0)

        XCTAssertTrue(gate.shouldEmit(payload: "1234567890123", now: .now))
    }

    func testSuppressesImmediateDuplicateEmission() {
        var gate = BarcodeEmissionGate(duplicateFilterInterval: 1.0)
        let now = Date()

        XCTAssertTrue(gate.shouldEmit(payload: "1234567890123", now: now))
        XCTAssertFalse(gate.shouldEmit(payload: "1234567890123", now: now.addingTimeInterval(0.4)))
    }

    func testAllowsDuplicateEmissionAfterCooldown() {
        var gate = BarcodeEmissionGate(duplicateFilterInterval: 1.0)
        let now = Date()

        XCTAssertTrue(gate.shouldEmit(payload: "1234567890123", now: now))
        XCTAssertTrue(gate.shouldEmit(payload: "1234567890123", now: now.addingTimeInterval(1.2)))
    }

    func testAlwaysAllowsDifferentPayload() {
        var gate = BarcodeEmissionGate(duplicateFilterInterval: 5.0)
        let now = Date()

        XCTAssertTrue(gate.shouldEmit(payload: "111", now: now))
        XCTAssertTrue(gate.shouldEmit(payload: "222", now: now.addingTimeInterval(0.1)))
    }
}
