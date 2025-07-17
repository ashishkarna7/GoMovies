//
//  GoMoviesUITests.swift
//  GoMoviesUITests
//
//  Created by Ashish Karna on 13/07/2025.
//

import XCTest

final class GoMoviesUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    @MainActor
    func testAppLaunchesSuccessfully() throws {
        let navTitle = app.navigationBars["Search Movies"].staticTexts["Search Movies"]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 5), "The navigation title should be visible")
        
    }
    
    @MainActor
    func testSearchFunctionality() throws {
        let searchMovieNavigationBar = app.navigationBars["Search Movies"]
        let searchField = searchMovieNavigationBar.searchFields["Search"]
        
        XCTAssertTrue(searchField.exists, "Search field should exist")
    }
}
