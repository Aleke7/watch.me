import UIKit

protocol SearchRoutingLogic {
    func routeToWatches(navigationController: UINavigationController?)
}

final class SearchRouter: SearchRoutingLogic {

    // MARK: - Properties

    weak var viewController: SearchViewController?

    // MARK: - Routing
    
    func routeToWatches(navigationController: UINavigationController?) {
        navigationController?.dismiss(animated: true)
    }
    
}
