//
//  ContentViewUITests.swift
//  ContentViewUITests
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

@testable import Meli
import XCTest

final class ContentViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        XCUIDevice.shared.orientation = .portrait
    }

    @MainActor
    func testTabViewAppearsAfterLaunch() {
        let tabView = app.otherElements["tabView"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: tabView, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(tabView.exists)
    }
}
