//
//  SearchProductsViewUITests.swift
//  MeliUITests
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

@testable import Meli
import XCTest
import SwiftUI

final class SearchProductsViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
    }

    @MainActor
    func testViewIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let searchProductsView = app.otherElements["searchProductsView"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchProductsView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchProductsView.exists)
    }

    @MainActor
    func testSearchTextfieldIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let searchProductsView = app.otherElements["searchProductsView"]
        let searchTextField = app.textFields["searchProductsTextfield"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchProductsView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: searchTextField, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchProductsView.exists)
        XCTAssertTrue(searchTextField.exists)
    }

    @MainActor
    func testEmptyViewIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let searchProductsView = app.otherElements["searchProductsView"]
        let emptyViewTitle = app.staticTexts["Search for your favorite product and you will find details about it."]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchProductsView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: emptyViewTitle, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchProductsView.exists)
        XCTAssertTrue(emptyViewTitle.exists)
    }

    @MainActor
    func testListViewIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let searchProductsView = app.otherElements["searchProductsView"]
        let searchTextField = app.textFields["searchProductsTextfield"]

        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchProductsView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: searchTextField, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchProductsView.exists)
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("iPhone")

        let listView = app.collectionViews["searchProductsListView"]

        expectation(for: existsPredicate, evaluatedWith: listView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(listView.exists)
    }

    @MainActor
    func testGridListViewIsPresent() {
        let app = XCUIApplication()
        app.launch()

        let searchProductsView = app.otherElements["searchProductsView"]
        let searchTextField = app.textFields["searchProductsTextfield"]

        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchProductsView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: searchTextField, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(searchProductsView.exists)
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("iPhone")

        let layoutListButton = app.buttons["layoutListButtonProductDetailView"]

        expectation(for: existsPredicate, evaluatedWith: layoutListButton, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(layoutListButton.exists)
        layoutListButton.tap()

        let gridListView = app.scrollViews["searchProductsGridListView"]

        expectation(for: existsPredicate, evaluatedWith: gridListView, handler: nil)

        waitForExpectations(timeout: 30, handler: nil)

        XCTAssertTrue(gridListView.exists)

    }
}
