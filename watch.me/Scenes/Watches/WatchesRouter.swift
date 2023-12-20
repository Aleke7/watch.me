import UIKit

protocol WatchesRoutingLogic {
    func routeToSearch(navigationController: UINavigationController?)
}

final class WatchesRouter: WatchesRoutingLogic {

    // MARK: - Properties

    weak var viewController: WatchesViewController?

    // MARK: - Routing
    
    func routeToSearch(navigationController: UINavigationController?) {
        let searchViewController = SearchAssembler.assemble()
        searchViewController.delegate = viewController
        navigationController?.present(searchViewController, animated: true)
    }
   
}
