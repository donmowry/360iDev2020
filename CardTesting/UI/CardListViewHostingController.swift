//
//  Copyright © 2020 Don Mowry
//

import SwiftUI

struct CardListViewHostingController {
    let topic: CardTopic
    
    func makeViewController() -> UIViewController {
        let hostingController = UIHostingController(rootView: CardListView(cards: topic.cards))
        hostingController.title  = topic.titles.stringForCurrentLanguage()
        hostingController.view.accessibilityIdentifier = "cardListView"
        return hostingController
    }
}
