//
//  Copyright © 2020 Don Mowry
//

import UIKit

final class CardTopicTableViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!

    var dataSource: CardListDataSource? {
        didSet {
            tableView.dataSource = dataSource
        }
    }
    
    weak var cardCoordinatorDelegate: CardCoordinatorDelegate?
    
    // MARK: - Static Functions
    
    class func make() -> CardTopicTableViewController? {
        let storyboard = UIStoryboard(name: "CardTopicTableView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CardTopicTableViewController") as? CardTopicTableViewController
        viewController?.loadViewIfNeeded()
        return viewController
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        configureNavigationBar()
        view.accessibilityIdentifier = "cardTopicTableViewController"
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
        super.viewWillAppear(animated)
    }
    
    // MARK: - Configuration
    
    func configureNavigationBar() {
        let flagLabel = UILabel()
        flagLabel.text = "🇮🇪"
        flagLabel.font = .boldSystemFont(ofSize: 48.0)
        flagLabel.sizeToFit()
        navigationItem.titleView = flagLabel
    }

}

extension CardTopicTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let topic = dataSource?.cardTopic(for: indexPath) else {
            assertionFailure("Could not find topic for \(indexPath)")
            return
        }
        
        cardCoordinatorDelegate?.viewController(viewController: self, didRequestShowTopic: topic)
    }
}

