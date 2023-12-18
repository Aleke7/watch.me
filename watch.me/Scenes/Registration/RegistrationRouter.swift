import UIKit

protocol RegistrationRoutingLogic {
    func routeToLogin(navigationController: UINavigationController?)
    func routeToActivation(navigationController: UINavigationController?)
}

final class RegistrationRouter: RegistrationRoutingLogic {

    // MARK: - Properties

    weak var viewController: RegistrationViewController?

    // MARK: - Routing

    func routeToLogin(navigationController: UINavigationController?) {
        if navigationController?.viewControllers.count != 1 {
            navigationController?.popViewController(animated: true)
            return
        }
        let loginViewController = LoginAssembler.assemble()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func routeToActivation(navigationController: UINavigationController?) {
        let activationViewController = ActivationAssembler.assemble()
        navigationController?.pushViewController(activationViewController, animated: true)
    }
}
