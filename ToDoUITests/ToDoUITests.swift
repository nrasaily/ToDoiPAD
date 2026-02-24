//
//  ToDoUITests.swift
//  ToDoUITests
//
//  Created by Nar Rasaily on 2/9/26.
//

import XCTest

final class ToDoUITests: XCTestCase {
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

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    func testLaunchInEnlish() throws {
        // 1. Force the app to launch in a language
        app.launchArguments = ["-AppleLanguages", "en"]
        app.launch()
        
        let header = app.staticTexts["Select a group to see more details."]
        XCTAssertTrue(header.exists, "Header is not displayed in English")
        
//        let app = XCUIApplication()
//        app.launch()
//        let button = app.buttons["en"]
//        button.isEmpty == false
    }
    
    func testLaunchInFrench() throws {
        app.launchArguments = ["-AppleLanguages", "fr"]
        app.launch()
        
        let header = app.staticTexts["Sélectionnez un groupe pour voir plus de détails."]
    }
    func testCreateNewTaskGroup() {
        app.launch()
        //let profileCard = app.buttons["Show_Add_Group_Button"]
        
        let addButton = app.buttons["Show_Add_Group_Button"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        
        let nameField = app.textFields["Group_Name"]
        XCTAssertTrue(nameField.exists)
        nameField.tap()
        nameField.typeText("Texting Group")
        
        let iconButton = app.images["icon_list.bullet"]
        XCTAssertTrue(iconButton.exists)
        iconButton.tap()
        app.buttons["Create_button"].tap()
        
    }
    
    func testNavigationToTaskGroup() {
        let app = XCUIApplication()
        app.launch()
//        let professorCard = app.buttons["ProfileCard_Professor"]
//        XCTAssertTrue(professorCard.exists,"The Professor card should be visible")
//        professorCard.tap()
        
        let schoolGroup = app.buttons["taskGroup_School"]
        XCTAssertTrue(schoolGroup.waitForExistence(timeout: 2), "The school group should be visible")
        schoolGroup.tap()
        
        let detailTitle = app.navigationBars["School"]
        XCTAssertTrue(detailTitle.exists, "The navigation bar should be visible")
    }
    
    func testTaskLifecycle_AddCompleteDelete() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["taskGroup_School"].tap()
        
        //app.buttons["ProfileCard_Professor"].tap()
        
        let addGroupButton = app.buttons["Add Task"]
        
        XCTAssertTrue(addGroupButton.exists)
        addGroupButton.tap()
        
        let allTextFields = app.textFields
        let lastTaskField = allTextFields.element(boundBy: allTextFields.count - 1)
        lastTaskField.tap()
        lastTaskField.typeText("Submit School homework")
        app.keyboards.buttons["Return"].tap()
        
        
        //let taskToggle = app.images.matching(identifier: "TaskToggle_").firstMatch
        //XCTAssertTrue(taskToggle.exists)
        //taskToggle.tap()
        
        lastTaskField.swipeLeft()
        app.buttons["Delete"].tap()
        
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: lastTaskField)
        let result = XCTWaiter().wait(for: [expectation], timeout: 4)
        XCTAssertEqual(result, .completed, "The task should be removed from the list")
    }
    
}
