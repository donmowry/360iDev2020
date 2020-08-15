//
//  Copyright © 2020 Don Mowry
//

import Foundation

final class ApplicationDependencies: CardDataProviderDependency {
    var cardTopicList: [CardTopic]
    
    init(cardTopicList: [CardTopic]) {
        self.cardTopicList = cardTopicList
    }
}

protocol CardDataProviderDependency {
    var cardTopicList: [CardTopic] { get }
}
