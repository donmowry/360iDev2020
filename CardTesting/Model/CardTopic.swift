//
//  Copyright © 2020 Don Mowry
//

import Foundation

struct CardTopic: Codable {
    let id: String
    let titles: LocaleDictionary
    let imageInformation: ImageInformation
    let cards: [Card]
}
