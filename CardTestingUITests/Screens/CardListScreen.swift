//
//  Copyright © 2020 Don Mowry
//

import XCTest

final class CardListScreen: ScreenRobot {
    
    override var viewName: String {
        "cardListView"
    }
    
    lazy private var backButton = app.navigationBars.buttons.firstMatch
    
    @discardableResult
    func flipCard(withTitle title: String,
                  translation: String,
                  toTopFaceUp: Bool = false,
                  timeout: TimeInterval = defaultTimeout) -> CardListScreen {
        
        assertView()
        let topFaceElement = app.otherElements[title]
        let bottomFaceElement = app.otherElements[translation]
        
        let faceUpElement = (toTopFaceUp ? bottomFaceElement : topFaceElement)
        let faceDownElement = (toTopFaceUp ? topFaceElement : bottomFaceElement)

        XCTAssert(faceUpElement.isHittable == true)
        XCTAssert(faceDownElement.isHittable == false)
        
        faceUpElement.tap()

        let predicate = NSPredicate(format: "isHittable == 1")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: faceDownElement)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            XCTAssert(false, "Element \(faceDownElement.identifier) is not hittable")
            return self
        }

        XCTAssert(faceUpElement.isHittable == false)
        XCTAssert(faceDownElement.isHittable == true)
        
        return self
    }

    @discardableResult
    func tapBack(timeout: TimeInterval = defaultTimeout) -> CardTopicsScreen {
        backButton.tap()
        assertView(exists: false, timeout: timeout)
        
        let cardTopicsScreen = CardTopicsScreen()
        cardTopicsScreen.assertView(exists: true, timeout: timeout)
        return cardTopicsScreen
    }
}
