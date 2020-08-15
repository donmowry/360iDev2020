//
//  Copyright © 2020 Don Mowry
//

import XCTest

class ScreenRobot: NSObject {
    
    class var defaultTimeout: TimeInterval {
        10.0
    }
    
    var app = XCUIApplication()
    var viewName: String {
        "view"
    }
    
    override init() {
        super.init()
        app.activate()
    }
    
    @discardableResult
    func tap(_ element: XCUIElement, timeout: TimeInterval = defaultTimeout) -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "isHittable == true"), object: element)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            XCTAssert(false, "Element \(element.label) not hittable")
            return self
        }
        element.tap()
        return self
    }

    @discardableResult
    func tapIfExists(_ element: XCUIElement, timeout: TimeInterval = defaultTimeout)  -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "isHittable == true"), object: element)
        if (XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed) {
            element.tap()
        }
        return self
    }
    
    @discardableResult
    func tapAndWaitForKeyboard(element: XCUIElement, timeout: TimeInterval = defaultTimeout) -> Self {
        tap(element)
        let keyboard = app.keyboards.element
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: keyboard)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            XCTAssert(false, "Keyboard did not appear")
            return self
        }
        return self
    }
    
    @discardableResult
    func assertView(exists: Bool = true, timeout: TimeInterval = defaultTimeout) -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == \(exists)"), object: app.otherElements[viewName])
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            let message = exists ? "does not exist" : "still exists"
            XCTAssert(false, "Screen \(viewName) \(message)")
            return self
        }
        return self
    }
    
    @discardableResult
    func waitForActivityIndicator(exists: Bool = true, timeout: TimeInterval = defaultTimeout) -> Self {
        let activityIndicatorElement = app.activityIndicators.firstMatch
        guard activityIndicatorElement.exists else {
            return self
        }
        activityIndicatorElement.wait(toExist: exists, timeout: timeout)
        return self
    }
}

extension XCUIElement {
    @discardableResult
    func clearText() -> XCUIElement {
        guard let string = self.value as? String, !string.isEmpty else {
            return self
        }
        doubleTap()
        tap()
        typeText("\u{8}")
        return self
    }

    @discardableResult func wait(toExist exists: Bool, timeout: TimeInterval = ScreenRobot.defaultTimeout) -> XCUIElement {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == \(exists)"), object: self)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            let message = exists ? "does not exist" : "still exists"
            XCTAssert(false, "Element \(self.description) \(message)")
            return self
        }
        return self
    }
    
    func performIf(exists: Bool = true, timeout: TimeInterval = ScreenRobot.defaultTimeout, completion: @escaping ((Bool) -> Void)) {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == \(exists)"), object: self)
        let result = (XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed)
        completion(result)
    }
}
