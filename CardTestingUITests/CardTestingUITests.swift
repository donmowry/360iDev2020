//
//  Copyright © 2020 Don Mowry
//

import XCTest

class CardTestingUITests: XCTestCase {

    func testSelectTopicAndFlipCard() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssert(app.otherElements["cardTopicTableViewController"].exists)
        
        app.tables.firstMatch.cells["topic_2"].tap()
        
        XCTAssert(app.otherElements["apple"].isHittable)
        XCTAssert(!app.otherElements["úll"].isHittable)
        
        app.otherElements["apple"].tap()
        
        let predicate = NSPredicate(format: "isHittable == 1")

        expectation(for: predicate, evaluatedWith: app.otherElements["úll"])
        waitForExpectations(timeout: 5.0)
        
        XCTAssert(!app.otherElements["apple"].isHittable)
        XCTAssert(app.otherElements["úll"].isHittable)
        
        app.buttons["Back"].tap()
 
        XCTAssert(app.otherElements["cardTopicTableViewController"].exists)
    }
   
    func testSelectTopicAndFlipCardWithRobot() {
        CardTopicsScreen()
            .selectTopic(withId: "topic_2")
            .flipCard(withTitle: "apple", translation: "úll")
            .flipCard(withTitle: "apple", translation: "úll", toTopFaceUp: true)
            .tapBack()
    }

}
