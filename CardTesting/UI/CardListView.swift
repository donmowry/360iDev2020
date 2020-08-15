//
//  Copyright © 2020 Don Mowry
//

import SwiftUI

struct CardListView: View {
    let cards: [Card]
    
    var body: some View {
        ScrollView {
            ForEach(self.cards) { card in
                CardView(card: card)
                    .scaledToFill()
                    .padding([.top, .bottom])
            }
            
        }
        
    }
}

struct CardListView_Previews: PreviewProvider {
    static let cards = [Card(id: "example",
                             titles: ["en": "English", "ga": "Irish"],
                             imageInformation: ImageInformation(id: "home_image",
                                                                sourceURL: nil,
                                                                attribution: nil)),
                        Card(id: "example_2",
                             titles: ["en": "EnglishTitle2", "ga": "IrishTitle2"],
                             imageInformation: ImageInformation(id: "apple_image",
                                                                sourceURL: nil,
                                                                attribution: nil)),
                        Card(id: "example_3",
                             titles: ["en": "EnglishTitle3", "ga": "IrishTitle3"],
                             imageInformation: ImageInformation(id: "water_image",
                                                                sourceURL: nil,
                                                                attribution: nil))]
    
    static var previews: some View {
        CardListView(cards: CardListView_Previews.cards)
    }
}
