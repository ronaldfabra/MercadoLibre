//
//  FavoritesProductsViewUITests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 15/02/25.
//

@testable import Meli
import XCTest

final class FavoritesProductsViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        XCUIDevice.shared.orientation = .portrait
    }

    @MainActor
    func testViewIsPresent() {
        let favoritesTab = app.tabBars.buttons["Favorites"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: favoritesTab, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(favoritesTab.exists)
        favoritesTab.tap()

        let favoritesProductsView = app.otherElements["favoritesProductsView"]

        expectation(for: existsPredicate, evaluatedWith: favoritesProductsView, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(favoritesProductsView.exists)
    }

    @MainActor
    func testEmptyViewIsPresent() {
        let favoritesTab = app.tabBars.buttons["Favorites"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: favoritesTab, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(favoritesTab.exists)
        favoritesTab.tap()

        let favoritesProductsView = app.otherElements["favoritesProductsView"]
        let emptyViewTitle = app.staticTexts["No favorites yet"]
        let emptyViewMessage = app.staticTexts["Add your favorite products to see their details"]

        expectation(for: existsPredicate, evaluatedWith: favoritesProductsView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: emptyViewTitle, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: emptyViewMessage, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(favoritesProductsView.exists)
        XCTAssertTrue(emptyViewTitle.exists)
        XCTAssertTrue(emptyViewMessage.exists)
    }
}
