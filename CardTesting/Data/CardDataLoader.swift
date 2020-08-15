//
//  Copyright © 2020 Don Mowry
//

import Foundation

struct CardDataLoader {
    
    static func loadSavedTopics() -> [CardTopic]? {
        guard let path = Bundle.main.path(forResource: "card_topics", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return nil
        }
        let jsonDecoder = JSONDecoder()
        let json = try? jsonDecoder.decode([CardTopic].self, from: jsonData)
        return json
    }
}
