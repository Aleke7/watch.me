import UIKit

protocol ActivationRoutingLogic {
    func routeToLogin(navigationController: UINavigationController?)
}

final class ActivationRouter: ActivationRoutingLogic {

    // MARK: - Properties

    weak var viewController: ActivationViewController?
    
    // MARK: - Routing
    
    func routeToLogin(navigationController: UINavigationController?) {
        let loginViewController = LoginAssembler.assemble()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
}
