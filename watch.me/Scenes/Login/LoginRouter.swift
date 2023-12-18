import UIKit

protocol LoginRoutingLogic {
    func routeToRegistration(navigationController: UINavigationController?)
    func routeToHome(navigationController: UINavigationController?, email: String)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {

    // MARK: - Properties

    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?

    // MARK: - Routing

    func routeToRegistration(navigationController: UINavigationController?) {
        if navigationController?.viewControllers.count != 1 {
            navigationController?.popViewController(animated: true)
            return
        }
        let registrationViewController = RegistrationAssembler.assemble()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    func routeToHome(navigationController: UINavigationController?, email: String) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
            if let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let homeTabBarController = HomeTabBarController(email: email)
                sceneDelegate.window?.rootViewController = homeTabBarController
            }
        }, completion: nil)
        
    }
}
