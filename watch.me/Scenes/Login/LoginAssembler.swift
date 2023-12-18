import Foundation

final class LoginAssembler {
    static func assemble() -> LoginViewController {
        let viewController = LoginViewController()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
