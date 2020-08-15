//
//  Copyright © 2020 Don Mowry
//

import UIKit
import SwiftUI

protocol CardCoordinatorDelegate: class {
    func viewController(viewController: UIViewController, didRequestShowTopic: CardTopic)
}

final class CardCoordinator: NSObject, Coordinator {
    
    typealias Dependencies = CardDataProviderDependency
    
    private let dependencies: Dependencies
    internal let navigationController: UINavigationController
    
    init(dependencies: Dependencies, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        guard let viewController = CardTopicTableViewController.make() else {
            assert(false, "Could not instantiate CardTopicTableViewController")
        }
        viewController.cardCoordinatorDelegate = self
        viewController.dataSource = CardListDataSource(cardTopics: dependencies.cardTopicList)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension CardCoordinator: CardCoordinatorDelegate {
    
    func viewController(viewController: UIViewController, didRequestShowTopic topic: CardTopic) {
        let viewController = CardListViewHostingController(topic: topic)
            .makeViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
