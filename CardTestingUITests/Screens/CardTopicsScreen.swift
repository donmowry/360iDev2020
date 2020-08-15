//
//  Copyright © 2020 Don Mowry
//

final class CardTopicsScreen: ScreenRobot {
    
    override var viewName: String {
        "cardTopicTableViewController"
    }
    
    lazy private var tableView = app.tables["cardTopicsTableView"]
    
    @discardableResult
    func selectTopic(withId cellId: String) -> CardListScreen {
        assertView()
        tableView.wait(toExist: true)
        tableView.cells[cellId].tap()
        
        let cardListScreen = CardListScreen()
        cardListScreen.assertView()
        return cardListScreen
    }

}
