import UIKit

protocol LoginRoutingLogic {
    func routeToRegistration(navigationController: UINavigationController?)
    func routeToHome(navigationController: UINavigationController?)
}

final class LoginRouter: LoginRoutingLogic {

    // MARK: - Properties

    weak var viewController: LoginViewController?

    // MARK: - Routing

    func routeToRegistration(navigationController: UINavigationController?) {
        if navigationController?.viewControllers.count != 1 {
            navigationController?.popViewController(animated: true)
            return
        }
        let registrationViewController = RegistrationAssembler.assemble()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    func routeToHome(navigationController: UINavigationController?) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
            if let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let homeTabBarController = HomeTabBarController()
                sceneDelegate.window?.rootViewController = homeTabBarController
            }
        }, completion: nil)
        
    }
}
