//
//  Copyright © 2020 Don Mowry
//

import UIKit

final class CardTopicTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "cardTopicCellIdentifier"
    
    @IBOutlet weak var topicImageView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var targetTopicLabel: UILabel!
    
    func configure(with topic: CardTopic) {
        topicLabel.text = topic.titles.stringForCurrentLanguage()
        targetTopicLabel.text = topic.titles.string(forLocale: "ga")
        topicImageView.image = UIImage(named: topic.imageInformation.id)
        accessibilityIdentifier = topic.id
    }
    
    override func prepareForReuse() {
        topicImageView.image = nil
        topicLabel.text = nil
    }
}
