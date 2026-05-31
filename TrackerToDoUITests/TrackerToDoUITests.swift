//
//  TrackerToDoUITests.swift
//  TrackerToDoUITests
//
//  Created by David Emery on 5/12/26.
//

import XCTest

final class TrackerToDoUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLaunchInEnglish(){
        app.launchArguments = ["-AppleLangueages", "en"]
        app.launch()
        
        let header = app.staticTexts["Who is working today?"]
        
        XCTAssertTrue(header.exists, "The English head is not found in english")
    }
    
    func testLaunchInSpanish() {
        app.launchArguments = ["-AppleLanguages", "es"]
        app.launch()
        let spanishHeader = app.staticTexts["Quién está trabajando hoy?"]
        XCTAssertTrue(spanishHeader.exists,"The spanish header is not found in spanish")
    }
    
    func testNewGroupLocalization() {
        app.launchArguments = ["-AppleLanguages", "es"]
        app.launch()
        
        let firstProfile = app.buttons.firstMatch
        
        if firstProfile.exists {
            let addButton = app.buttons["AddGroupButton"]
            
            if addButton.waitForExistence(timeout: 2) {
                addButton.tap()
                
                XCTAssertTrue(app.staticTexts["Nombre dep grupo"].exists)
                
                XCTAssertTrue(app.staticTexts["Seleccionar icono"].exists)
            }
            
        }
    }
    
}
