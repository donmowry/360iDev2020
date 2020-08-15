//
//  Copyright © 2020 Don Mowry
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appDependencies: ApplicationDependencies?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        makeMainCoordinator(with: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator?.start()
    }
    
    // MARK: Coordinator initialization
    
    private func makeApplicationDependencies() -> ApplicationDependencies {
        guard let cardTopics = CardDataLoader.loadSavedTopics() else {
            assert(false, "Could not load bundled card topics")
        }
        
        return ApplicationDependencies(cardTopicList: cardTopics)
    }
    
    private func makeMainCoordinator(with navigationController: UINavigationController) {
        let dependencies = makeApplicationDependencies()
        appDependencies = dependencies
        let cardCoordinator = CardCoordinator(dependencies: dependencies,
                                              navigationController: navigationController)
        coordinator = cardCoordinator as Coordinator
    }
    

}

