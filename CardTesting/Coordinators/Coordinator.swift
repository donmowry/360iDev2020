//
//  Copyright © 2020 Don Mowry
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get }
    
    func start()
}
