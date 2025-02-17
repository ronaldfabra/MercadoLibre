//
//  ProductDetailViewUITests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 16/02/25.
//

@testable import Meli
import XCTest
import SwiftUI

final class ProductDetailViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
    }

    @MainActor
    func testViewIsPresent() {
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

        let productDetailRow = listView.cells.element(boundBy: 0)

        XCTAssertTrue(productDetailRow.exists)
        productDetailRow.tap()

        let detailView = app.scrollViews["productDetailView"]

        expectation(for: existsPredicate, evaluatedWith: detailView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(detailView.exists, "La vista de detalles no existe")
    }

    @MainActor
    func testShareProductViewIsPresent() {
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

        let productDetailRow = listView.cells.element(boundBy: 0)

        XCTAssertTrue(productDetailRow.exists)
        productDetailRow.tap()

        let detailView = app.scrollViews["productDetailView"]

        expectation(for: existsPredicate, evaluatedWith: detailView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(detailView.exists)

        let shareButton = app.buttons["shareButtonProductDetailView"]

        expectation(for: existsPredicate, evaluatedWith: shareButton, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(shareButton.exists)
        shareButton.tap()

        let shareProductView = app.otherElements["shareProductView"]

        expectation(for: existsPredicate, evaluatedWith: shareProductView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(shareProductView.exists)
    }
}
