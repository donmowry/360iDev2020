//
//  Copyright © 2020 Don Mowry
//  

import UIKit

final class CardListDataSource: NSObject {
    
    private let cardTopics: [CardTopic]
    
    init(cardTopics: [CardTopic]) {
        self.cardTopics = cardTopics
        
        super.init()
    }
    
    func cardTopic(for indexPath: IndexPath) -> CardTopic? {
        guard indexPath.row < cardTopics.count else {
            return nil
        }
        return cardTopics[indexPath.row]
    }
}

extension CardListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTopicTableViewCell.cellIdentifier, for: indexPath)
        
        if let topicCell = cell as? CardTopicTableViewCell,
            let topic = cardTopic(for: indexPath){
            topicCell.configure(with: topic)
        }
            
        return cell
    }
    
}
