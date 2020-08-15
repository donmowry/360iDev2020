//
//  Copyright © 2020 Don Mowry
//

import Foundation

struct Card: Codable, Identifiable {
    let id: String
    let titles: LocaleDictionary
    let imageInformation: ImageInformation
}
