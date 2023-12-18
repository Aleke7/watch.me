import UIKit

protocol RegistrationRoutingLogic {
    func routeToLogin(navigationController: UINavigationController?)
    func routeToActivation(navigationController: UINavigationController?, maskedEmail: String)
}

protocol RegistrationDataPassing {
    var dataStore: RegistrationDataStore? { get }
}

final class RegistrationRouter: RegistrationRoutingLogic, RegistrationDataPassing {

    // MARK: - Properties

    weak var viewController: RegistrationViewController?
    var dataStore: RegistrationDataStore?

    // MARK: - Routing

    func routeToLogin(navigationController: UINavigationController?) {
        if navigationController?.viewControllers.count != 1 {
            navigationController?.popViewController(animated: true)
            return
        }
        let registrationViewController = LoginAssembler.assemble()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    func routeToActivation(navigationController: UINavigationController?, maskedEmail: String) {
        let activationViewController = ActivationAssembler.assemble(maskedEmail: maskedEmail)
        navigationController?.pushViewController(activationViewController, animated: true)
    }
}
